import 'package:blavapp/components/_pages/appbar_extention.dart';
import 'package:flutter/material.dart';

class RootStaticPage extends StatelessWidget {
  final String titleText;
  final Widget body;

  const RootStaticPage({
    Key? key,
    required this.titleText,
    required this.body,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(titleText),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Stack(
          children: [
            body,
            _addAppBarExtension(context),
          ],
        ),
      ),
    );
  }

  Positioned _addAppBarExtension(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      child: CustomPaint(
        painter: AppBarExtention(
          context: context,
        ),
      ),
    );
  }
}
