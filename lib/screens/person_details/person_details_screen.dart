import 'package:flutter/material.dart';
import 'package:movie_night/enums/media_type_enum.dart';
import 'package:movie_night/models/credit_model.dart';
import 'package:movie_night/models/person_details_model.dart';
import 'package:movie_night/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/tv_show_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/constants.dart';
import 'package:movie_night/services/pagination_service.dart';
import 'package:movie_night/services/person_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/pagination.dart';
import 'package:movie_night/widgets/rating_chip.dart';

class PersonDetailsScreen extends StatefulWidget {
  final int personId;
  const PersonDetailsScreen({Key? key, required this.personId}) : super(key: key);

  @override
  State<PersonDetailsScreen> createState() => _PersonDetailsScreenState();
}

class _PersonDetailsScreenState extends State<PersonDetailsScreen> {

  PersonDetails? personDetails;

  int currentCastPage = 1;
  int totalCastPages = 1;
  int totalCastItems = 0;
  PaginationService<Credit>? castCreditsPagination;
  List<Credit>? displayedCastCredits;

  int currentCrewPage = 1;
  int totalCrewPages = 1;
  int totalCrewItems = 0;
  PaginationService<Credit>? crewCreditsPagination;
  List<Credit>? displayedCrewCredits;

  @override
  void initState() {
    getPersonDetails(widget.personId).then((PersonDetails value) {
      if(value.combinedCredits != null) {
        final List<Credit> castCredits = (value.combinedCredits["cast"] as List<dynamic>).map((e) => Credit.fromJson(e)).toList();
        castCreditsPagination = PaginationService(items: castCredits, maxItemsPerPage: itemsPerPageSm);

        final List<Credit> crewCredits = (value.combinedCredits["crew"] as List<dynamic>).map((e) => Credit.fromJson(e)).toList();
        crewCreditsPagination = PaginationService(items: crewCredits, maxItemsPerPage: itemsPerPageSm);
      }
      setState(() {
        personDetails = value;

        totalCastPages = castCreditsPagination!.totalPages;
        totalCastItems = castCreditsPagination!.itemCount;
        displayedCastCredits = castCreditsPagination!.getItemsForPage(currentCastPage);

        totalCrewPages = crewCreditsPagination!.totalPages;
        totalCrewItems = crewCreditsPagination!.itemCount;
        displayedCrewCredits = crewCreditsPagination!.getItemsForPage(currentCrewPage);
      });
    });
    super.initState();
  }

  void onCastPageChange(int newPage) {
    setState(() {
      currentCastPage = newPage;
      displayedCastCredits = castCreditsPagination!.getItemsForPage(newPage);
    });
  }

  void onCrewPageChange(int newPage) {
    setState(() {
      currentCrewPage = newPage;
      displayedCrewCredits = crewCreditsPagination!.getItemsForPage(newPage);
    });
  }

  void onCreditTap(MediaType type, int mediaId) {
    if(type == MediaType.movie) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: mediaId),));
    } else if(type == MediaType.tv) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetailsScreen(tvShowId: mediaId),));
    }
  }

  Widget getCastCreditsSection() {
    return Column(
      children: [
        const DividerMargin(),
        Text("Cast credits", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Text("Page $currentCastPage of $totalCastPages ($totalCastItems results).", textAlign: TextAlign.center),
        for(final credit in displayedCastCredits!) ListTile(
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
          onTap: () => onCreditTap(credit.mediaType, credit.mediaId),
        ),
        Pagination(
            currentPage: currentCastPage,
            totalPages: totalCastPages,
            onPageChange: onCastPageChange
        ),
      ],
    );
  }

  Widget getCrewCreditsSection() {
    return Column(
      children: [
        const DividerMargin(),
        Text("Crew credits", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Text("Page $currentCrewPage of $totalCrewPages ($totalCrewItems results).", textAlign: TextAlign.center),
        for(final Credit credit in displayedCrewCredits!) ListTile(
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
          subtitle: credit.job != null ? Text(credit.job!) : null,
          onTap: () => onCreditTap(credit.mediaType, credit.mediaId),
        ),
        Pagination(
            currentPage: currentCrewPage,
            totalPages: totalCrewPages,
            onPageChange: onCrewPageChange
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
            if(displayedCastCredits != null && displayedCastCredits!.isNotEmpty) getCastCreditsSection(),
            if(displayedCrewCredits != null && displayedCrewCredits!.isNotEmpty) getCrewCreditsSection(),
          ],
        ),
      ),
    );
  }
}
