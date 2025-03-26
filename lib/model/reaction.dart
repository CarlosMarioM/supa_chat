class Reaction {
  Reaction({
    required this.id,
    required this.profileId,
    required this.messageId,
    required this.value,
    required this.createdAt,
  });

  final String id, profileId, messageId, value;

  final DateTime createdAt;

  Reaction.fromMap({
    required Map<String, dynamic> map,
  })  : id = map['id'],
        profileId = map['profile_id'],
        messageId = map['message_id'],
        value = map['value'],
        createdAt = DateTime.parse(map['created_at']);
}
