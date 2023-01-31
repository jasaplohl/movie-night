import 'package:flutter/material.dart';
import 'package:movie_night/models/media_model.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_card.dart';

class MediaRow extends StatelessWidget {
  final String? title;
  final List<Media>? media;

  const MediaRow({Key? key, this.title, this.media}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if(title != null) Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Text(title!, style: Theme.of(context).textTheme.headlineSmall),
        ),
        media == null ? const LoadingSpinner() : SizedBox(
          height: 400,
          child: ListView.builder(
            itemCount: media!.length,
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return MediaCard(key: ValueKey(media![index].id), media: media![index]);
            },
          ),
        )
      ],
    );
  }
}
