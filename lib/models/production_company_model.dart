class ProductionCompany {
  final int id;
  final String name;
  final String? logoPath;
  final String originCountry;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
    required this.originCountry,
  });

  factory ProductionCompany.fromJson(dynamic json) {
    return ProductionCompany(
        id: json["id"],
        name: json["name"],
        logoPath: json["logo_path"],
        originCountry: json["origin_country"],
    );
  }
}