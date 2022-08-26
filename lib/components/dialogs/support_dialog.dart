import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SupportDialog extends StatefulWidget {
  final Function(String title, String message) onSubmit;
  final String? title;
  const SupportDialog({
    Key? key,
    this.title,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<SupportDialog> createState() => _SupportDialogState();
}

class _SupportDialogState extends State<SupportDialog> {
  String title = '';
  String message = '';
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.title ?? AppLocalizations.of(context)!.compDialogSendMessage,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            AppLocalizations.of(context)!.genSubject,
            style: Theme.of(context).textTheme.subtitle1,
          ),
          const SizedBox(height: 4),
          TextField(
            onChanged: (value) => setState(() {
              title = value;
            }),
            autocorrect: false,
            maxLines: 1,
          ),
          const SizedBox(height: 16),
          Text(
            AppLocalizations.of(context)!.genRequest,
            style: Theme.of(context).textTheme.subtitle2,
          ),
          const SizedBox(height: 4),
          TextField(
            onChanged: (value) => setState(() {
              message = value;
            }),
            autocorrect: false,
            maxLines: 10,
          ),
        ],
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            widget.onSubmit(title, message);
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
