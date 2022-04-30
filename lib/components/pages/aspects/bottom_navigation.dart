import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/utils/app_themes.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBottomNavigationBar extends StatelessWidget {
  final List<IconData> items;
  final Function(int) onTap;
  final int index;

  const AppBottomNavigationBar({
    Key? key,
    required this.items,
    required this.onTap,
    this.index = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AppTheme appTheme =
        BlocProvider.of<ThemeBloc>(context).state.appTheme;
    return CurvedNavigationBar(
      index: index,
      items: items
          .map(
            (e) => Icon(e, color: Theme.of(context).primaryIconTheme.color),
          )
          .toList(),
      backgroundColor: appTheme == AppTheme.dark
          ? Theme.of(context).scaffoldBackgroundColor.withOpacity(0.5)
          : Colors.transparent,
      buttonBackgroundColor: getAppBarColor(context),
      color: getAppBarColor(context),
      height: 60,
      onTap: onTap,
    );
  }
}
