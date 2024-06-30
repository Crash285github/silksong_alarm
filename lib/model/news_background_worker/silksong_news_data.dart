import 'dart:convert';

/// A data class containing the latest saved Daily Silksong News data
class SilksongNewsData {
  /// The id of the latest Silksong News Video
  final String id;

  /// The title of the latest Silksong News Video
  final String title;

  /// The description of the latest Silksong News Video
  final String description;

  /// The length of the latest Silksong News Video in seconds
  final int seconds;

  const SilksongNewsData({
    required this.id,
    required this.title,
    required this.description,
    required this.seconds,
  });

  /// Converts `this` [SilksongNewsData] into a `Map` object
  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'description': description,
      'seconds': seconds,
    };
  }

  /// Converts a valid `Map` object into a [SilksongNewsData] object
  factory SilksongNewsData.fromMap(Map<String, dynamic> map) {
    return SilksongNewsData(
      id: map['id'] as String,
      title: map['title'] as String,
      description: map['description'] as String,
      seconds: map['seconds'] as int,
    );
  }

  /// Converts `this` [SilksongNewsData] into a `json` [String]
  String toJson() => json.encode(toMap());

  /// Converts a valid `json` [String] into a [SilksongNewsData] object
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
