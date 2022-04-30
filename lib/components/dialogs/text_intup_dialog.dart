import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class TextInputDialog extends StatefulWidget {
  final Function(String message) onSubmit;
  final String? title;
  const TextInputDialog({
    Key? key,
    this.title,
    required this.onSubmit,
  }) : super(key: key);

  @override
  State<TextInputDialog> createState() => _TextInputDialogState();
}

class _TextInputDialogState extends State<TextInputDialog> {
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
        children: [
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
            widget.onSubmit(message);
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
