import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class QRScannerDialog extends StatelessWidget {
  final Function() onScanned;
  final String? title;
  const QRScannerDialog({
    Key? key,
    this.title,
    required this.onScanned,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? AppLocalizations.of(context)!.compDialogQRScanner,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: const [],
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
