import 'package:flutter/material.dart';
import 'package:movie_night/models/episode_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/widgets/divider_margin.dart';

class EpisodeSection extends StatelessWidget {
  final String sectionTitle;
  final Episode episode;

  const EpisodeSection({
    Key? key,
    required this.sectionTitle,
    required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const DividerMargin(),
        Text(sectionTitle, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        const SizedBox(height: 10,),
        if(episode.airDate != null) Text("Air date: ${formatDateString(episode.airDate!)}"),
        Text("Season ${episode.seasonNumber}"),
        ListTile(
          leading: episode.stillPath != null ? FadeInImage.assetNetwork(
            image: getBackdropUrl(episode.stillPath!),
            placeholder: "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: 40,
            height: 60,
          ) : null,
          title: Text("${episode.name} (episode ${episode.episodeNumber})", style: Theme.of(context).textTheme.labelLarge,),
          subtitle: Text(episode.overview.isNotEmpty ? episode.overview : "No description available."),
        ),
      ],
    );
  }
}
