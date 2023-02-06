import 'package:movie_night/models/credit_model.dart';

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
  final dynamic images; // TODO: horizontal pages for images? or display more images
  final List<Credit>? cast;
  final List<Credit>? crew;

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
    required this.images,
    required this.cast,
    required this.crew,
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
      images: json["images"],
      cast: json["combined_credits"]["cast"] != null ? (json["combined_credits"]["cast"] as List<dynamic>).map((dynamic e) => Credit.fromJson(e),).toList() : null,
      crew: json["combined_credits"]["crew"] != null ? (json["combined_credits"]["crew"] as List<dynamic>).map((dynamic e) => Credit.fromJson(e),).toList() : null,
    );
  }
}