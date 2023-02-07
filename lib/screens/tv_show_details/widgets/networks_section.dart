import 'package:flutter/material.dart';
import 'package:movie_night/models/network_model.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/widgets/custom_chip.dart';
import 'package:movie_night/widgets/divider_margin.dart';

class NetworksSection extends StatelessWidget {
  final List<Network> networks;
  const NetworksSection({Key? key, required this.networks}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const DividerMargin(),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("Networks", style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
            ),
          ],
        ),
        Wrap(
          alignment: WrapAlignment.center,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for(final Network network in networks) CustomChip(
              label: network.name,
              imagePath: network.logoPath != null ? getImageUrl(network.logoPath!) : null,
            ),
          ],
        ),
      ],
    );
  }
}
