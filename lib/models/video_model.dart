class Video {
  final String id;
  final String publishedAt;
  final bool official;
  final String type;
  final String site;
  final String key;
  final String name;

  Video({
    required this.id,
    required this.publishedAt,
    required this.official,
    required this.type,
    required this.site,
    required this.key,
    required this.name,
  });

  factory Video.fromJson(dynamic json) {
    return Video(
      id: json["id"],
      publishedAt: json["published_at"],
      official: json["official"],
      type: json["type"],
      site: json["site"],
      key: json["key"],
      name: json["name"],
    );
  }
}