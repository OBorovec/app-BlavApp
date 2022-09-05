import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/components/pages/page_root.dart';
import 'package:blavapp/components/views/title_divider.dart';
import 'package:blavapp/utils/notifications_local.dart';
import 'package:blavapp/utils/notifications_push.dart';
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const _LanguageOptions(),
                  const _ThemeOptions(),
                  // NOTE: Uncomment in the next versions so that the user can change their currency preference.
                  // const _CurrenryOptions(),
                  TitleDivider(
                    title: AppLocalizations.of(context)!.settingsNotification,
                  ),
                  _CheckboxOption(
                    text:
                        AppLocalizations.of(context)!.settingsNotificationPush,
                    value: (UserLocalPrefsState state) =>
                        state.allowPushNotifications,
                    onChanged: (bool? value) {
                      BlocProvider.of<UserLocalPrefsBloc>(context).add(
                        AllowUserPushNotification(value),
                      );
                      pushNotificationToggle(value, context);
                    },
                  ),
                  _CheckboxOption(
                    text: AppLocalizations.of(context)!
                        .settingsNotificationProgramme,
                    value: (UserLocalPrefsState state) =>
                        state.allowProgrammeNotifications,
                    onChanged: (bool? value) {
                      BlocProvider.of<UserLocalPrefsBloc>(context).add(
                        AllowUserProgrammeNotification(value),
                      );
                      localNotificationToggle(value, context);
                    },
                  ),
                  const _UserNotificationIntervals(),
                  // _CheckboxOption(
                  //   text:
                  //       AppLocalizations.of(context)!.settingsNotificationStory,
                  //   value: (UserLocalPrefsState state) =>
                  //       state.allowStoryNotifications,
                  //   onChanged: (bool? value) =>
                  //       BlocProvider.of<UserLocalPrefsBloc>(context).add(
                  //     AllowUserStoryNotification(value),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
        ),
        const Divider(),
        const _Signature(),
      ],
    );
  }
}

class _LanguageOptions extends StatelessWidget {
  const _LanguageOptions({
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

class _ThemeOptions extends StatelessWidget {
  const _ThemeOptions({
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

class _CurrenryOptions extends StatelessWidget {
  const _CurrenryOptions({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(AppLocalizations.of(context)!.settingsCurrency),
            DropdownButton<UserCurrencyPref>(
              value: state.currency,
              onChanged: (UserCurrencyPref? newPref) {
                BlocProvider.of<UserLocalPrefsBloc>(context).add(
                  SetUserCurrencyPref(newPref ?? UserCurrencyPref.czk),
                );
              },
              items: [
                DropdownMenuItem<UserCurrencyPref>(
                  value: UserCurrencyPref.czk,
                  child: Text(
                    AppLocalizations.of(context)!.settingsCurrencyOptCZK,
                  ),
                ),
                DropdownMenuItem<UserCurrencyPref>(
                  value: UserCurrencyPref.eur,
                  child: Text(
                    AppLocalizations.of(context)!.settingsCurrencyOptEur,
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

class _UserNotificationIntervals extends StatelessWidget {
  const _UserNotificationIntervals({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
      builder: (context, state) {
        return state.allowProgrammeNotifications
            ? Column(
                children: [
                  Text(AppLocalizations.of(context)!
                      .settingsNotificationIntervas),
                  const SizedBox(height: 4),
                  Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: _buildIntervalBtn(
                            context,
                            state.notify10min,
                            '10',
                            (() {
                              BlocProvider.of<UserLocalPrefsBloc>(context)
                                  .add(const Toggle10minNotification());
                              localNotificationToggle(true, context);
                            }),
                          ),
                        ),
                        const SizedBox(width: 1),
                        Expanded(
                          child: _buildIntervalBtn(
                            context,
                            state.notify30min,
                            '30',
                            (() {
                              BlocProvider.of<UserLocalPrefsBloc>(context)
                                  .add(const Toggle30minNotification());
                              localNotificationToggle(true, context);
                            }),
                          ),
                        ),
                        const SizedBox(width: 1),
                        Expanded(
                          child: _buildIntervalBtn(
                            context,
                            state.notify60min,
                            '60',
                            (() {
                              BlocProvider.of<UserLocalPrefsBloc>(context)
                                  .add(const Toggle60minNotification());
                              localNotificationToggle(true, context);
                            }),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(AppLocalizations.of(context)!
                      .settingsNotificationIntervasUnits),
                ],
              )
            : Container();
      },
    );
  }

  Widget _buildIntervalBtn(
    BuildContext context,
    bool isActive,
    String text,
    Function() onTap,
  ) {
    return Container(
      color: isActive ? Theme.of(context).focusColor : null,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            text,
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}

class _CheckboxOption extends StatelessWidget {
  final String text;
  final bool Function(UserLocalPrefsState) value;
  final void Function(bool?) onChanged;
  const _CheckboxOption({
    Key? key,
    required this.text,
    required this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserLocalPrefsBloc, UserLocalPrefsState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Switch(
              value: value(state),
              onChanged: onChanged,
            ),
          ],
        );
      },
    );
  }
}

class _Signature extends StatelessWidget {
  const _Signature({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
      child: Row(
        children: [
          Expanded(
            child: Text(
              AppLocalizations.of(context)!.aboutProject,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption,
              maxLines: 3,
            ),
          ),
          IconButton(
            onPressed: () => launchUrl(
              Uri.parse('https://github.com/OBorovec/BlavApp'),
            ),
            icon: const Icon(EvaIcons.github),
          ),
        ],
      ),
    );
  }
}
