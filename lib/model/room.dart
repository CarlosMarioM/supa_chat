class Room {
  Room({
    this.id = '',
    required this.value,
    required this.createdAt,
  });

  final String id, value;

  final DateTime createdAt;

  Room.fromMap({
    required Map<String, dynamic> map,
  })  : id = map['id'],
        value = map['value'],
        createdAt = DateTime.parse(map['created_at']);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'value': value,
      'created_at': DateTime.parse(createdAt.toIso8601String()),
    };
  }
}
