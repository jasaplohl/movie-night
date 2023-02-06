import 'package:flutter/material.dart';
import 'package:movie_night/models/person_details_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/services/credits_section.dart';
import 'package:movie_night/services/person_service.dart';
import 'package:movie_night/widgets/loading_spinner.dart';

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
            if(personDetails!.cast != null && personDetails!.cast!.isNotEmpty) CreditsSection(sectionTitle: "Cast credits", credits: personDetails!.cast!),
            if(personDetails!.crew != null && personDetails!.crew!.isNotEmpty) CreditsSection(sectionTitle: "Crew credits", credits: personDetails!.crew!),
          ],
        ),
      ),
    );
  }
}
