class PersonDetails {
  final int id;
  final String name;
  final String? birthday;
  final String? deathday;
  final String? biography;
  final String? knownForDepartment;
  final List<String>? alsoKnownAs;
  final String? placeOfBirth;
  final String? profilePath;
  final String? homePage;
  final List<String>? images;
  final List<dynamic>? combinedCredits;

  PersonDetails({
    required this.id,
    required this.name,
    required this.birthday,
    required this.deathday,
    required this.biography,
    required this.knownForDepartment,
    required this.alsoKnownAs,
    required this.placeOfBirth,
    required this.profilePath,
    required this.homePage,
    required this.images,
    required this.combinedCredits,
  });

  factory PersonDetails.fromJson(dynamic json) {
    return PersonDetails(
      id: json["id"],
      name: json["name"],
      birthday: json["birthday"],
      deathday: json["deathday"],
      biography: json["biography"],
      knownForDepartment: json["known_for_department"],
      alsoKnownAs: json["also_known_as"] != null ? (json["also_known_as"] as List<dynamic>).map((dynamic e) => e.toString()).toList() : null,
      placeOfBirth: json["place_of_birth"],
      profilePath: json["profile_path"],
      homePage: json["home_page"],
      images: json["images"],
      combinedCredits: json["combined_credits"],
    );
  }
}