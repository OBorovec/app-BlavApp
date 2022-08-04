import 'package:blavapp/components/page_hierarchy/appbar_extention.dart';
import 'package:flutter/material.dart';

class RedirectPage extends StatelessWidget {
  final String titleText;
  final String redirectMessage;
  final String route;
  final int duration;

  const RedirectPage({
    Key? key,
    required this.titleText,
    required this.redirectMessage,
    required this.route,
    this.duration = 3,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: duration), () {
      Navigator.popAndPushNamed(context, route);
    });
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
            Positioned.fill(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const CircularProgressIndicator(),
                  Text(
                    redirectMessage,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline4,
                  ),
                ],
              ),
            ),
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
