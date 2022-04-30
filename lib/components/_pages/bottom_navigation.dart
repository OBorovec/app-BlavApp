import 'package:blavapp/utils/app_themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final List<IconData> items;
  final Function(int) onTap;

  const AppBottomNavigationBar({
    Key? key,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: items
          .map(
            (e) => Icon(e, color: Theme.of(context).primaryIconTheme.color),
          )
          .toList(),
      // backgroundColor: Colors.transparent,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
      buttonBackgroundColor: getAppBarColor(context),
      color: getAppBarColor(context),
      height: 60,
      onTap: onTap,
    );
  }
}
