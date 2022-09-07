import 'package:flutter/material.dart';

abstract class ButtonSwitch extends StatelessWidget {
  final bool isOn;
  final Color? onColor;
  final Function() onPressed;
  final IconData onIconData;
  final IconData offIconData;
  final double? iconSize;
  final EdgeInsetsGeometry? padding;
  final BoxConstraints? constraints;

  const ButtonSwitch({
    Key? key,
    required this.isOn,
    this.onColor,
    required this.onPressed,
    required this.onIconData,
    required this.offIconData,
    this.iconSize,
    this.padding,
    this.constraints,
  }) : super(key: key);

  @override
  IconButton build(BuildContext context) {
    return IconButton(
      onPressed: onPressed,
      icon: Icon(
        isOn ? onIconData : offIconData,
        size: iconSize,
        color: isOn ? onColor : null,
      ),
      padding: padding ?? const EdgeInsets.all(8.0),
      constraints: constraints,
    );
  }
}

class BookmarkSwitch extends ButtonSwitch {
  const BookmarkSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.bookmark_added,
          offIconData: Icons.bookmark_add,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class EditSaveSwitch extends ButtonSwitch {
  const EditSaveSwitch({
    Key? key,
    required bool isOn,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onPressed: onPressed,
          onIconData: Icons.save,
          offIconData: Icons.edit,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class EmailVerifiedSwitch extends ButtonSwitch {
  const EmailVerifiedSwitch({
    Key? key,
    required bool isOn,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onPressed: onPressed,
          onIconData: Icons.verified,
          offIconData: Icons.outgoing_mail,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class NotificationSwitch extends ButtonSwitch {
  const NotificationSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.notifications_active,
          offIconData: Icons.notification_add,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class SearchSwitch extends ButtonSwitch {
  const SearchSwitch({
    Key? key,
    required bool isOn,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onPressed: onPressed,
          onIconData: Icons.search,
          offIconData: Icons.search_off,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class AddSwitch extends ButtonSwitch {
  const AddSwitch({
    Key? key,
    required bool isOn,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onPressed: onPressed,
          onIconData: Icons.add,
          offIconData: Icons.cancel,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class FavoriteSwitch extends ButtonSwitch {
  const FavoriteSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.favorite,
          offIconData: Icons.favorite_border,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class CheckBoxSwitch extends ButtonSwitch {
  const CheckBoxSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.check_box_rounded,
          offIconData: Icons.check_box_outline_blank_rounded,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class AddBoxSwitch extends ButtonSwitch {
  const AddBoxSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.add_box_outlined,
          offIconData: Icons.add_box,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}

class ExploreSwitch extends ButtonSwitch {
  const ExploreSwitch({
    Key? key,
    required bool isOn,
    Color? onColor,
    required Function() onPressed,
    double? iconSize,
    EdgeInsetsGeometry? padding,
    BoxConstraints? constraints,
  }) : super(
          key: key,
          isOn: isOn,
          onColor: onColor,
          onPressed: onPressed,
          onIconData: Icons.explore,
          offIconData: Icons.explore_off,
          iconSize: iconSize,
          padding: padding,
          constraints: constraints,
        );
}
