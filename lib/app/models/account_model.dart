class Account {
  final String id;
  final String name;
  final String description;
  final String profileUrl;

  Account({
    required this.id,
    required this.name,
    required this.description,
    required this.profileUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'description': description,
      'profileUrl': profileUrl,
    };
  }

  factory Account.fromMap(Map<String, dynamic> map) {
    return Account(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      profileUrl: map['profileUrl'] as String,
    );
  }

  @override
  String toString() =>
      'Event(id: $id, name: $name, description: $description, profileUrl: $profileUrl)';
}
