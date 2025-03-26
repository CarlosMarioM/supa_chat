import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_chat_reactions/utilities/hero_dialog_route.dart';
import 'package:flutter_chat_reactions/widgets/stacked_reactions.dart';
import 'package:supa_chat/constants.dart';

import 'package:supa_chat/model/message.dart';
import 'package:supa_chat/model/profile.dart';
import 'package:supa_chat/model/reaction.dart';
import 'package:supa_chat/model/room.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:timeago/timeago.dart';
import 'package:flutter_chat_reactions/flutter_chat_reactions.dart';

part 'widgets/chat_bubble.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key, required this.room}) : super(key: key);

  final Room room;

  static Route<void> route(Room room) {
    return MaterialPageRoute(
      builder: (context) => ChatPage(room: room),
    );
  }

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  late final Stream<List<Message>> _messagesStream;
  final Map<String, Profile> _profileCache = {};

  @override
  void initState() {
    final myUserId = supabase.auth.currentUser?.id;
    if (myUserId == null) return;

    _messagesStream = supabase
        .from('messages')
        .stream(primaryKey: ['id'])
        .eq('room_id', widget.room.id)
        .order('created_at')
        .map((maps) => maps
            .map(
              (map) => Message.fromMap(
                map: map,
                myUserId: myUserId,
              ),
            )
            .toList());

    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future<void> _loadProfileCache(String profileId) async {
    if (_profileCache[profileId] != null) {
      return;
    }
    final data =
        await supabase.from('profiles').select().eq('id', profileId).single();
    final profile = Profile.fromMap(data);
    setState(() {
      _profileCache[profileId] = profile;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.room.value)),
      body: StreamBuilder<List<Message>>(
        stream: _messagesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return preloader;
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          final messages = snapshot.data ?? [];

          return Column(
            children: [
              Expanded(
                child: messages.isEmpty
                    ? const Center(
                        child: Text('Start your conversation now :)'))
                    : ListView.builder(
                        key: PageStorageKey(widget.room.id),
                        addRepaintBoundaries: true,
                        addAutomaticKeepAlives: true,
                        reverse: true,
                        itemCount: messages.length,
                        itemBuilder: (context, index) {
                          final message = messages[index];
                          _loadProfileCache(message.profileId);
                          return _ChatBubble(
                            message: message,
                            key: ValueKey(message.id),
                          );
                        },
                      ),
              ),
              _MessageBar(roomId: widget.room.id),
            ],
          );
        },
      ),
    );
  }
}

class _MessageBar extends StatefulWidget {
  const _MessageBar({Key? key, required this.roomId}) : super(key: key);

  final String roomId;

  @override
  State<_MessageBar> createState() => _MessageBarState();
}

class _MessageBarState extends State<_MessageBar> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  Future<void> _submitMessage() async {
    final text = _textController.text.trim();
    final myUserId = supabase.auth.currentUser?.id;

    if (text.isEmpty || myUserId == null) return;

    _textController.clear();
    try {
      await supabase.from('messages').insert({
        'profile_id': myUserId,
        'content': text,
        'room_id': widget.roomId,
      });
    } catch (error) {
      context.showErrorSnackBar(
          message: error is PostgrestException
              ? error.message
              : unexpectedErrorMessage);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.grey[200],
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  controller: _textController,
                  keyboardType: TextInputType.text,
                  maxLines: null,
                  autofocus: true,
                  decoration: const InputDecoration(
                    hintText: 'Type a message',
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.all(8),
                  ),
                ),
              ),
              TextButton(
                onPressed: _submitMessage,
                child: const Text('Send'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
