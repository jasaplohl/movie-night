import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/credit_model.dart';
import 'package:movie_night/models/person_details_model.dart';
import 'package:movie_night/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/tv_show_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/person_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/rating_chip.dart';

class PersonDetailsScreen extends StatefulWidget {
  final int personId;
  const PersonDetailsScreen({Key? key, required this.personId}) : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {

  PersonDetails? personDetails;

  @override
  void initState() {
    getPersonDetails(widget.personId).then((PersonDetails value) {
      setState(() {
        personDetails = value;
      });
    });
    super.initState();
  }

  // TODO: Show crew credits as well, paginate the credits
  Widget getCreditsSection() {
    List<Credit> castCredits = (personDetails!.combinedCredits["cast"] as List<dynamic>).map((e) => Credit.fromJson(e)).toList();
    return Column(
      children: [
        const DividerMargin(),
        Text("Cast credits", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        for(final credit in castCredits) ListTile(
          leading: credit.posterPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(credit.posterPath!),
            placeholder: "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: 40,
            height: 60,
          ) : Image.asset(
            "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: 40,
            height: 60,
          ),
          title: Text(credit.title ?? "No title"),
          trailing: RatingChip(rating: credit.voteAverage),
          subtitle: Text("Character: ${credit.character != null && credit.character!.isNotEmpty ? credit.character : 'Unknown'}"),
          onTap: () {
            if(credit.mediaType == MediaType.movie) {
              Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: credit.mediaId),));
            } else {
              Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetailsScreen(tvShowId: credit.mediaId),));
            }
          },
        ),
      ],
    );
  }

  // TODO: "Also known as" section
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personDetails == null ? "" : personDetails!.name),
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline, color: Colors.red,)
          )
        ],
      ),
      body: personDetails == null ?
      const LoadingSpinner() :
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: ListView(
          children: [
            Text(personDetails!.name, style: Theme.of(context).textTheme.headlineLarge,),
            if(personDetails!.birthday != null) Container(
              margin: const EdgeInsets.symmetric(vertical: 5),
              child: Text(
                  "Born on ${formatDateString(personDetails!.birthday!)}${personDetails!.placeOfBirth != null ? ' in ${personDetails!.placeOfBirth!}.' : '.'}"
              ),
            ),
            if(personDetails!.deathday != null) Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Died on ${formatDateString(personDetails!.deathday!)}"),
            ),
            if(personDetails!.knownForDepartment != null) Container(
                margin: const EdgeInsets.symmetric(vertical: 5),
                child: Text("Known for ${personDetails!.knownForDepartment!}."),
            ),
            if(personDetails!.profilePath != null) Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: Image.network(
                getImageUrl(personDetails!.profilePath!),
                height: 300,
                width: 200,
              ),
            ),
            if(personDetails!.biography != null) Text(personDetails!.biography!),
            if(personDetails!.combinedCredits != null) getCreditsSection(),
          ],
        ),
      ),
    );
  }
}
