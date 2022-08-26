import 'package:flutter/material.dart';

import 'aspects/appbar_extention.dart';

class SidePage extends StatefulWidget {
  final String titleText;
  final Widget body;
  final Widget? floatingActionButton;
  final List<Widget>? actions;

  const SidePage({
    Key? key,
    required this.titleText,
    required this.body,
    this.actions,
    this.floatingActionButton,
  }) : super(key: key);

  @override
  State<SidePage> createState() => _SidePageState();
}

class _SidePageState extends State<SidePage> {
  DateTime currentBackPressTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.titleText),
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: const Icon(Icons.arrow_back),
          ),
          actions: widget.actions,
        ),
        body: Stack(
          children: [
            Positioned.fill(
              child: widget.body,
            ),
            _addAppBarExtension(context),
          ],
        ),
        floatingActionButton: widget.floatingActionButton,
        resizeToAvoidBottomInset: false,
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
