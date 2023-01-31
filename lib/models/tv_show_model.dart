class TvShowDetails {
  final String name;

  TvShowDetails({
    required this.name,
  });

  factory TvShowDetails.fromJson(dynamic json) {
    return TvShowDetails(
      name: json["name"],
    );
  }
}