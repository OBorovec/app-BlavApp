import 'package:blavapp/components/_pages/root_page.dart';
import 'package:flutter/material.dart';

class EventHomePage extends StatelessWidget {
  const EventHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const RootPage(
      titleText: '',
      body: Center(
        child: Text('HomePage'),
      ),
    );
  }
}
