class Person {
  final int id;
  final String name;
  final String? birthday;
  final String? deathday;
  final String biography;
  final String? knownForDepartment;
  final List<String>? alsoKnownAs;
  final String? placeOfBirth;
  final String? profilePath;
  final String? homePage;

  Person({
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
  });

  factory Person.fromJson(dynamic json) {
    return Person(
      id: json["id"],
      name: json["name"],
      birthday: json["birthday"],
      deathday: json["deathday"],
      biography: json["biography"],
      knownForDepartment: json["known_for_department"],
      alsoKnownAs: (json["also_known_as"] as List<dynamic>).map((dynamic e) => e.toString()).toList(),
      placeOfBirth: json["place_of_birth"],
      profilePath: json["profile_path"],
      homePage: json["home_page"],
    );
  }
}