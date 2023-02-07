import 'package:flutter/material.dart';
import 'package:movie_night/models/collection_model.dart';
import 'package:movie_night/services/movie_service.dart';
import 'package:movie_night/utils/show_error_dialog.dart';
import 'package:movie_night/widgets/divider_margin.dart';
import 'package:movie_night/widgets/loading_spinner.dart';
import 'package:movie_night/widgets/media_row.dart';

class CollectionSection extends StatefulWidget {
  final int collectionId;
  const CollectionSection({Key? key, required this.collectionId}) : super(key: key);

  @override
  State<CollectionSection> createState() => _CollectionSectionState();
}

class _CollectionSectionState extends State<CollectionSection> {

  Collection? collection;

  @override
  void initState() {
    getCollection(widget.collectionId).then((Collection value) {
      setState(() {
        collection = value;
      });
    }).catchError((err) {
      showErrorDialog(context, err.toString());
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getCollection(widget.collectionId),
      builder: (context, AsyncSnapshot<Collection> snapshot) {
        if(snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if(snapshot.hasData) {
          final Collection collection = snapshot.data!;
          return Column(
            children: [
              const DividerMargin(),
              Text(collection.name, style: Theme.of(context).textTheme.headlineSmall!.copyWith(color: Theme.of(context).primaryColorLight)),
              Container(
                margin: const EdgeInsets.all(10),
                child: Text(collection.overview, textAlign: TextAlign.center),
              ),
              MediaRow(
                media: collection.parts,
              )
            ],
          );
        }
        return const LoadingSpinner();
      },
    );
  }
}
