class Announcement {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  Announcement({
    required this.id,
    required this.title,
    required this.description,
    required this.imageUrl,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
    };
  }

  factory Announcement.fromMap(Map<String, dynamic> map) {
    return Announcement(
      id: map['id'] as String,
      title: map['name'] as String,
      description: map['description'] as String,
      imageUrl: map['imageUrl'] as String,
    );
  }

  @override
  String toString() =>
      'Event(id: $id, name: $title, description: $description, imageUrl: $imageUrl)';
}
