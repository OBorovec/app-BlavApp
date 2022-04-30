import 'dart:io';

import 'package:blavapp/views/drawer/drawer_main.dart';
import 'package:flutter/material.dart';

import 'aspects/appbar_extention.dart';

class RootPage extends StatefulWidget {
  final String titleText;
  final Widget body;
  final List<Widget>? actions;
  final Widget? floatingActionButton;
  final Widget? bottomNavigationBar;

  const RootPage({
    Key? key,
    required this.titleText,
    required this.body,
    this.actions,
    this.floatingActionButton,
    this.bottomNavigationBar,
  }) : super(key: key);

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  DateTime currentBackPressTime =
      DateTime.now().subtract(const Duration(seconds: 10));

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => onWillPop(context),
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: Text(widget.titleText),
          elevation: 0,
          actions: widget.actions,
        ),
        drawer: const MainDrawer(),
        body: Stack(
          children: [
            Positioned.fill(child: widget.body),
            _addAppBarExtension(context),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
        bottomNavigationBar: widget.bottomNavigationBar,
        extendBody: true,
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  Widget _addAppBarExtension(BuildContext context) {
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

  Future<bool> onWillPop(BuildContext context) {
    final DateTime now = DateTime.now();
    if (now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      // Toasting.notifyToast(
      //   context,
      //   AppLocalizations.of(context)!.toatingDoubleTapExit,
      // );
      _scaffoldKey.currentState?.openDrawer();
      return Future.value(false);
    }
    exit(0);
    // return Future.value(true);
  }
}
