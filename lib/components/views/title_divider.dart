import 'package:flutter/material.dart';

class TitleDivider extends StatelessWidget {
  final String title;
  const TitleDivider({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Expanded(child: Divider()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Text(
            title,
            style: Theme.of(context).textTheme.headline5,
          ),
        ),
        const Expanded(child: Divider()),
      ],
    );
  }
}