class Network {
  final int id;
  final String name;
  final String? logoPath;

  Network({
    required this.id,
    required this.name,
    required this.logoPath,
  });

  factory Network.fromJson(dynamic json) {
    return Network(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"],
    );
  }
}