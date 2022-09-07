import 'package:blavapp/components/control/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class SearchDialog extends StatelessWidget {
  final Function(String) onSearchChange;
  final Widget content;
  const SearchDialog({
    Key? key,
    required this.onSearchChange,
    required this.content,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        AppLocalizations.of(context)!.genSearch,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        children: [
          SearchTextField(onChange: onSearchChange),
          const Divider(),
          content,
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
