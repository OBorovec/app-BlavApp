import 'dart:io';

import 'package:blavapp/bloc/admin/voting_data/voting_data_bloc.dart';
import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/contacts/data_contacts/contacts_bloc.dart';
import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/maps/data_maps/maps_bloc.dart';
import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/app/event/event_bloc.dart';
import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/bloc/story/bloc/story_bloc.dart';
import 'package:blavapp/bloc/user_data/local_user_data/local_user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/bloc/user_data/user_perms/user_perms_bloc.dart';
import 'package:blavapp/constants/colors.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/services/local_notification_service.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:blavapp/services/push_notification_service.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalNotificationService().init();
  _configureLocalTimeZone();
  Bloc.observer = AppBlocObserver();
  runApp(const BlavApp());
}

Future<void> _configureLocalTimeZone() async {
  if (kIsWeb || Platform.isLinux) {
    return;
  }
  tz.initializeTimeZones();
  final String timeZoneName = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(timeZoneName));
}

class AppBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    // print(change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print(transition);
  }
}

class BlavApp extends StatefulWidget {
  const BlavApp({Key? key}) : super(key: key);

  @override
  State<BlavApp> createState() => _BlavAppState();
}

class _BlavAppState extends State<BlavApp> {
  late final Future<List> _future = Future.wait(
    [
      SharedPreferences.getInstance(),
      Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform,
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _future,
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if (snapshot.hasError) {
          return _buildMaterialError(snapshot.error.toString());
        } else if (snapshot.connectionState == ConnectionState.done) {
          PushNotificationService().init();
          final SharedPreferences sharedPreferences =
              snapshot.requireData[0] as SharedPreferences;
          // final FirebaseApp firebaseApp =
          //     snapshot.requireData[1] as FirebaseApp;
          return MultiRepositoryProvider(
            providers: [
              RepositoryProvider(
                create: (context) => PrefsRepo(sharedPreferences),
              ),
              RepositoryProvider(
                create: (context) => AuthRepo(),
              ),
              RepositoryProvider(
                create: (context) => DataRepo(),
              ),
              RepositoryProvider(
                create: (context) => StorageRepo(),
              ),
            ],
            child: MultiBlocProvider(
              // App state providers
              providers: [
                BlocProvider(
                  create: (context) => LocalizationBloc(
                    prefs: context.read<PrefsRepo>(),
                    initState: LocalizationBloc.loadLang(
                      context.read<PrefsRepo>(),
                    ),
                  ),
                ),
                BlocProvider(
                  create: (context) => ThemeBloc(
                    prefs: context.read<PrefsRepo>(),
                    initState: ThemeBloc.loadTheme(
                      context.read<PrefsRepo>(),
                    ),
                  ),
                ),
                BlocProvider(
                  create: (context) => AuthBloc(
                    authRepo: context.read<AuthRepo>(),
                  ),
                ),
                BlocProvider(
                  lazy: false,
                  create: (context) => EventBloc(
                    prefs: context.read<PrefsRepo>(),
                    dataRepo: context.read<DataRepo>(),
                  ),
                ),
              ],
              child: MultiBlocProvider(
                providers: [
                  // User data providers
                  BlocProvider(
                    lazy: false,
                    create: (context) => UserDataBloc(
                      authBloc: context.read<AuthBloc>(),
                      dataRepo: context.read<DataRepo>(),
                      eventFocusBloc: context.read<EventBloc>(),
                    ),
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) => LocalUserDataBloc(
                      prefs: context.read<PrefsRepo>(),
                    ),
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) => UserPermsBloc(
                      authBloc: context.read<AuthBloc>(),
                      dataRepo: context.read<DataRepo>(),
                    ),
                  ),
                  BlocProvider(
                    lazy: false,
                    create: (context) => UserLocalPrefsBloc(
                      prefs: context.read<PrefsRepo>(),
                      initState: UserLocalPrefsBloc.load(
                        context.read<PrefsRepo>(),
                      ),
                    ),
                  ),
                ],
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return BlocBuilder<LocalizationBloc, LocalizationState>(
                      builder: (context, localizationState) {
                        return BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, authState) {
                            return BlocBuilder<UserPermsBloc, UserPermsState>(
                              builder: (context, userPermsState) {
                                return BlocBuilder<EventBloc, EventState>(
                                  builder: (context, eventState) {
                                    // bool hasEvent = eventState.status ==
                                    //     EventStatus.selected;
                                    // Event data providers
                                    return MultiBlocProvider(
                                      providers: [
                                        BlocProvider(
                                          create: (context) => CateringBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => ContactsBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => CosplayBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => DegustationBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => MapsBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => ProgrammeBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => StoryBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                        BlocProvider(
                                          create: (context) => VotingDataBloc(
                                            dataRepo: context.read<DataRepo>(),
                                            eventFocusBloc:
                                                context.read<EventBloc>(),
                                          ),
                                        ),
                                      ],
                                      child: _buildMaterialApp(
                                        context,
                                        themeState,
                                        localizationState,
                                        authState,
                                        userPermsState,
                                        eventState,
                                      ),
                                    );
                                  },
                                );
                              },
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return SizedBox(
            height: double.infinity,
            width: double.infinity,
            child: Container(
              color: AppColors.scaffoldLight,
            ),
          );
        }
      },
    );
  }

  Widget _buildMaterialApp(
    BuildContext context,
    ThemeState themeState,
    LocalizationState localizationState,
    AuthState authState,
    UserPermsState userPermsState,
    EventState eventState,
  ) {
    final bool isAuthenticated = authState.status == AuthStatus.auth;
    final bool hasEvent = eventState.status == EventStatus.selected;
    final bool isAdmin = userPermsState.isAdmin;
    final bool isStaff = userPermsState.isStaff;
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'BlavApp',
      debugShowCheckedModeBanner: false,
      theme: themeState.themeData,
      locale: localizationState.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: RoutePaths.welcome,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(
        settings: settings,
        isAuthenticated: isAuthenticated,
        hasEvent: hasEvent,
        isAdmin: isAdmin,
        isStaffMember: isStaff,
      ),
    );
  }

  Widget _buildMaterialError(
    String message,
  ) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(message),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}
