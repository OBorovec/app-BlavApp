import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class CollapsableTextSection extends StatelessWidget {
  final String title;
  final String body;
  final bool isExpanded;
  final Function() onToggle;
  const CollapsableTextSection({
    Key? key,
    required this.title,
    required this.body,
    required this.isExpanded,
    required this.onToggle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onToggle,
          child: Row(
            children: [
              const SizedBox(
                width: 10,
                child: Divider(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: Text(
                  title,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              const Expanded(child: Divider()),
              isExpanded
                  ? const Icon(Icons.keyboard_arrow_up)
                  : const Icon(Icons.keyboard_arrow_down),
            ],
          ),
        ),
        if (isExpanded) Text(body),
        if (isExpanded)
          InkWell(
            onTap: onToggle,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(AppLocalizations.of(context)!.genShowLess),
                const Icon(Icons.keyboard_arrow_up),
              ],
            ),
          ),
      ],
    );
  }
}
