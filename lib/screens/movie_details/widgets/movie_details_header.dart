import 'package:flutter/material.dart';
import 'package:movie_night/services/common_services.dart';

class MovieDetailsHeader extends StatelessWidget {
  final String title;
  final String? releaseDate;
  final String status;
  final num voteAverage;
  final int voteCount;
  final int? runtime;
  final String originalLanguage;
  final String? homePage;

  const MovieDetailsHeader({
    Key? key,
    required this.title,
    required this.releaseDate,
    required this.status,
    required this.voteAverage,
    required this.voteCount,
    required this.runtime,
    required this.originalLanguage,
    required this.homePage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.headlineLarge),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  if(releaseDate != null)  Container(
                    margin: const EdgeInsets.only(right: 10),
                    child: Text(formatDateString(releaseDate!)),
                  ),
                  Chip(
                    label: Text(status),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: Icon(Icons.star_rate_rounded, color: Theme.of(context).primaryColorLight),
                  ),
                  Text(voteAverage.toString(), style: Theme.of(context).textTheme.headlineSmall,),
                  Text(" (${formatNumber(voteCount)})"),
                ],
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if(runtime != null) Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(Icons.timer_outlined),
                  ),
                  Text("${runtime!.toString()} min"),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin: const EdgeInsets.only(right: 5),
                    child: const Icon(Icons.speaker_notes),
                  ),
                  Text(originalLanguage.toUpperCase()),
                ],
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          if(homePage != null) ElevatedButton(
            onPressed: () => goToUrl(homePage!, context),
            child: const Text("Home page"),
          ),
        ],
      ),
    );
  }
}
