class Message {
  Message(
      {required this.id,
      required this.profileId,
      required this.content,
      required this.createdAt,
      required this.isMine,
      required this.roomId});

  final String id, profileId, content, roomId;

  final DateTime createdAt;

  final bool isMine;

  Message.fromMap({
    required Map<String, dynamic> map,
    required String myUserId,
  })  : id = map['id'],
        profileId = map['profile_id'],
        content = map['content'],
        createdAt = DateTime.parse(map['created_at']),
        isMine = myUserId == map['profile_id'],
        roomId = map['room_id'];
}
