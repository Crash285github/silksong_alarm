// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class SilksongNewsData {
  final String id;
  final String title;
  final String description;
  final int seconds;

  SilksongNewsData({
    required this.id,
    required this.title,
    required this.description,
    required this.seconds,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'seconds': seconds,
    };
  }

  factory SilksongNewsData.fromMap(Map<String, dynamic> map) {
    return SilksongNewsData(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      seconds: map['seconds'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory SilksongNewsData.fromJson(String source) =>
      SilksongNewsData.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool operator ==(covariant SilksongNewsData other) {
    if (identical(this, other)) return true;

    return other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
