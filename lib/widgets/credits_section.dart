import 'package:flutter/material.dart';
import 'package:movie_night/utils/media_type_enum.dart';
import 'package:movie_night/models/credit_model.dart';
import 'package:movie_night/screens/movie_details/movie_details_screen.dart';
import 'package:movie_night/screens/person_details/person_details_screen.dart';
import 'package:movie_night/screens/tv_show_details/tv_show_details_screen.dart';
import 'package:movie_night/services/common_services.dart';
import 'package:movie_night/utils/constants.dart';
import 'package:movie_night/utils/pagination_service.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/pagination.dart';
import 'package:movie_night/widgets/rating_chip.dart';

class CreditsSection extends StatefulWidget {
  final String sectionTitle;
  final List<Credit> credits;
  const CreditsSection({Key? key, required this.sectionTitle, required this.credits}) : super(key: key);

  @override
  State<CreditsSection> createState() => _CreditsSectionState();
}

class _CreditsSectionState extends State<CreditsSection> {

  int currentPage = 1;
  int totalPages = 1;
  int totalItems = 0;
  PaginationService<Credit>? creditsPagination;
  List<Credit>? displayedCredits;

  @override
  void initState() {
    creditsPagination = PaginationService(items: widget.credits, maxItemsPerPage: itemsPerPageSm);

    setState(() {
      totalPages = creditsPagination!.totalPages;
      totalItems = creditsPagination!.itemCount;
      displayedCredits = creditsPagination!.getItemsForPage(currentPage);
    });
    super.initState();
  }

  void onPageChange(int newPage) {
    setState(() {
      currentPage = newPage;
      displayedCredits = creditsPagination!.getItemsForPage(newPage);
    });
  }

  void onCreditTap(MediaType type, int mediaId) {
    if(type == MediaType.movie) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MovieDetailsScreen(movieId: mediaId),));
    } else if(type == MediaType.tv) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => TvShowDetailsScreen(tvShowId: mediaId),));
    } else if(type == MediaType.person) {
      Navigator.push(context, MaterialPageRoute(builder: (context) => PersonDetailsScreen(personId: mediaId),));
    }
  }
  
  String getRole(Credit credit) {
    if(credit.character != null) {
      return "Character: ${credit.character}";
    } else if (credit.job != null) {
      return "Job: ${credit.job}";
    } else {
      return "Role: unknown";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const DividerMargin(),
        Text(widget.sectionTitle, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
        Text("Page $currentPage of $totalPages ($totalItems results).", textAlign: TextAlign.center),
        const SizedBox(height: 10),
        for(final credit in displayedCredits!) ListTile(
          leading: credit.posterPath != null ? FadeInImage.assetNetwork(
            image: getImageUrl(credit.posterPath!),
            placeholder: credit.mediaType == MediaType.person ? "lib/assets/images/default_avatar.webp" : "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: imageWidthSm,
            height: imageHeightSm,
          ) : Image.asset(
            credit.mediaType == MediaType.person ? "lib/assets/images/default_avatar.webp" : "lib/assets/images/default_img.webp",
            fit: BoxFit.cover,
            width: imageWidthSm,
            height: imageHeightSm,
          ),
          title: Text(credit.title ?? "No title"),
          trailing: credit.voteAverage != null ? RatingChip(rating: credit.voteAverage!) : null,
          subtitle: Text(getRole(credit)),
          onTap: () => onCreditTap(credit.mediaType, credit.mediaId),
        ),
        Pagination(
            currentPage: currentPage,
            totalPages: totalPages,
            onPageChange: onPageChange
        ),
      ],
    );
  }
}
