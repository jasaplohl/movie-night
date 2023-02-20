import 'package:flutter/material.dart';
import 'package:movie_night/services/common_services.dart';

class ImageCarousel extends StatelessWidget {
  final List<String> images;
  const ImageCarousel({Key? key, required this.images}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(images.length);
    return SizedBox(
      height: 250,
      child: PageView.builder(
        itemCount: images.length,
        scrollDirection: Axis.horizontal,
        controller: PageController(viewportFraction: 0.9),
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            child: Image.network(getBackdropUrl(images[index])),
          );
        },
      ),
    );
  }
}
