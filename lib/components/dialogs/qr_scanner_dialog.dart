import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

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
    final double width = MediaQuery.of(context).size.width;
    return AlertDialog(
      title: Text(
        title ?? AppLocalizations.of(context)!.compDialogQRScanner,
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: width,
            height: width,
            child: MobileScanner(
              allowDuplicates: false,
              onDetect: (barcode, args) {
                print(barcode);
              },
            ),
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
