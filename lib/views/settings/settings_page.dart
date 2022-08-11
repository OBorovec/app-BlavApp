import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/components/page_hierarchy/root_page.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return RootPage(
      titleText: AppLocalizations.of(context)!.settingsTitle,
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          const LanguageOptions(),
          const ThemeOption(),
          Expanded(child: Container()),
          const Divider(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Text(
              AppLocalizations.of(context)!.aboutDevBy,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
            ),
          ),
          const Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                onPressed: () => launchUrl(
                  Uri.parse('https://github.com/OBorovec/BlavApp'),
                ),
                icon: const Icon(EvaIcons.github),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class LanguageOptions extends StatelessWidget {
  const LanguageOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocalizationBloc, LocalizationState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.settingsLang),
            DropdownButton<AppLang>(
              value: state.appLang,
              onChanged: (AppLang? newLang) {
                BlocProvider.of<LocalizationBloc>(context).add(
                  ChangeLang(appLang: newLang ?? AppLang.auto),
                );
              },
              items: [
                DropdownMenuItem<AppLang>(
                  value: AppLang.auto,
                  child: Text(
                    AppLocalizations.of(context)!.settingsLangOptAuto,
                  ),
                ),
                DropdownMenuItem<AppLang>(
                  value: AppLang.en,
                  child: Text(
                    AppLocalizations.of(context)!.settingsLangOptEN,
                  ),
                ),
                DropdownMenuItem<AppLang>(
                  value: AppLang.cs,
                  child: Text(
                    AppLocalizations.of(context)!.settingsLangOptCS,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class ThemeOption extends StatelessWidget {
  const ThemeOption({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.settingsTheme),
            Switch(
              value: state.appTheme == AppTheme.dark,
              onChanged: (value) {
                BlocProvider.of<ThemeBloc>(context).add(
                  value ? const SetDarkTheme() : const SetLightTheme(),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
