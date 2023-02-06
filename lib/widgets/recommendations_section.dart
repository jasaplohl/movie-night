import 'package:flutter/material.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/media_card.dart';

class RecommendationsSection extends StatelessWidget {
  final List<Media> recommended;
  const RecommendationsSection({Key? key, required this.recommended}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerMargin(),
        Text("Recommended", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Wrap(
          direction: Axis.horizontal,
          children: [
            for(final Media media in recommended) MediaCard(
                key: ValueKey(media.id),
                media: media,
            )
          ],
        )
      ],
    );
  }
}
