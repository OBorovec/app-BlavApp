import 'package:blavapp/components/control/rating_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ReviewDialog extends StatefulWidget {
  final Function(double rating, String message) onSubmit;
  final String? title;
  const ReviewDialog({
    Key? key,
    this.title,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<ReviewDialog> createState() => _ReviewDialogState();
}

class _ReviewDialogState extends State<ReviewDialog> {
  double rating = 0;
  String message = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title ?? AppLocalizations.of(context)!.compDialogFeedback,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppRatingBar(
            onRating: ((rating) => setState(() => this.rating = rating)),
          ),
          const SizedBox(height: 16),
          TextField(
            onChanged: (value) => setState(() {
              message = value;
            }),
            maxLines: 10,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onSubmit(rating, message);
            Navigator.pop(context);
          },
          child: Text(AppLocalizations.of(context)!.genSend),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(AppLocalizations.of(context)!.genDismiss),
        ),
      ],
    );
  }
}
