import 'package:flutter/material.dart';

abstract class ControlButton extends StatelessWidget {
  final TextStyle? textStyle;
  final Function() onPressed;

  const ControlButton({
    Key? key,
    required this.onPressed,
    this.textStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      child: Text(
        getText(context),
        style: textStyle,
      ),
    );
  }

  String getText(BuildContext context);
}
