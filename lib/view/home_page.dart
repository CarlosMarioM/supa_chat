import 'package:flutter/material.dart';
import 'package:supa_chat/constants.dart';
import 'package:supa_chat/model/room.dart';
import 'package:supa_chat/view/chat_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static Route<void> route() {
    return MaterialPageRoute(
      builder: (context) => const HomePage(),
    );
  }

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Stream<List<Room>> _roomsStream;
  List<Room> rooms = [];
  late final TextEditingController roomController;
  @override
  void initState() {
    super.initState();
    roomController = TextEditingController();

    _roomsStream = supabase
        .from('rooms')
        .stream(primaryKey: ['id'])
        .order('created_at')
        .map(
          (maps) => maps.map((map) => Room.fromMap(map: map)).toList(),
        );
    WidgetsBinding.instance
        .addPostFrameCallback((_) async => await _getChatRooms());
  }

  Future<void> _getChatRooms() async {
    final values = await supabase.from('rooms').select();
    rooms = values.map((e) => Room.fromMap(map: e)).toList();
    setState(() {});
  }

  void _createChatRoom(String room) async {
    await supabase.from('rooms').insert({'value': room});
    roomController.text = "";
    await _getChatRooms();
  }

  @override
  void dispose() {
    roomController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Room>>(
          stream: _roomsStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return preloader;
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            rooms = snapshot.requireData;
            return SafeArea(
              minimum: const EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: rooms.length,
                      itemBuilder: (context, index) {
                        if (rooms.isEmpty) {
                          return const Text(
                              "No room created, try creating one!");
                        }
                        return GestureDetector(
                          onTap: () => _roomTapped(rooms[index].value),
                          child: ListTile(
                            title: Text(rooms[index].value),
                          ),
                        );
                      },
                    ),
                  ),
                  TextFormField(
                    controller: roomController,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () => _createChatRoom(roomController.text),
                      child: const Text("Create room"),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  void _roomTapped(String roomValue) async {
    final value = await supabase
        .from('rooms')
        .select()
        .eq('value', roomValue)
        .maybeSingle();

    if (value == null) return;

    Room room = Room.fromMap(map: value);

    _navigateToChatPage(room);
  }

  void _navigateToChatPage(Room room) {
    Navigator.of(context).push(ChatPage.route(room));
  }
}
