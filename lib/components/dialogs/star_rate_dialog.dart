import 'package:blavapp/components/control/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class StarRateDialog extends StatelessWidget {
  final Function(double rating) onRate;
  final String? title;
  const StarRateDialog({
    Key? key,
    this.title,
    required this.onRate,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? AppLocalizations.of(context)!.compDialogStarRating,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          AppRatingBar(
            onRating: ((rating) {
              onRate(rating);
              Navigator.pop(context);
            }),
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.genDismiss),
        ),
      ],
    );
  }
}
