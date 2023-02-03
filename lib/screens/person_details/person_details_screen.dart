import 'package:flutter/material.dart';
import 'package:movie_night/models/person_details_model.dart';
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
      ListView(
        children: [
          Text(personDetails!.name),
          // TODO: Img, birthday, deathday?
          if(personDetails!.biography != null) Text(personDetails!.biography!),
        ],
      ),
    );
  }
}
