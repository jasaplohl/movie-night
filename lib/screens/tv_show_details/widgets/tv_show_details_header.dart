import 'package:flutter/material.dart';
import 'package:movie_night/services/common_services.dart';

class TvShowDetailsHeader extends StatelessWidget {

  final String name;
  final num voteAverage;
  final int voteCount;
  final String firstAirDate;
  final String lastAirDate;
  final int? runtime;
  final String originalLanguage;
  final String? homepage;

  const TvShowDetailsHeader({
    Key? key,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
    required this.firstAirDate,
    required this.lastAirDate,
    required this.runtime,
    required this.originalLanguage,
    required this.homepage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(name, style: Theme.of(context).textTheme.headlineLarge),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
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
        Text("First air date: ${formatDateString(firstAirDate)}"),
        const SizedBox(height: 10),
        Text("Last air date: ${formatDateString(lastAirDate)}"),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if(runtime != null) Text("Episode runtime: $runtime min"),
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
        const SizedBox(height: 10),
        if(homepage != null) ElevatedButton(
          onPressed: () => goToUrl(homepage!, context),
          child: const Text("Home page"),
        ),
      ],
    );
  }
}
