import 'package:blavapp/bloc/app/auth/auth_bloc.dart';
import 'package:blavapp/bloc/catering/data_catering/catering_bloc.dart';
import 'package:blavapp/bloc/cosplay/data_cospaly/cosplay_bloc.dart';
import 'package:blavapp/bloc/degustation/data_degustation/degustation_bloc.dart';
import 'package:blavapp/bloc/maps/data_maps/maps_bloc.dart';
import 'package:blavapp/bloc/programme/data_programme/programme_bloc.dart';
import 'package:blavapp/bloc/app/event_focus/event_focus_bloc.dart';
import 'package:blavapp/bloc/app/localization/localization_bloc.dart';
import 'package:blavapp/bloc/app/theme/theme_bloc.dart';
import 'package:blavapp/bloc/user_data/user_data/user_data_bloc.dart';
import 'package:blavapp/bloc/user_data/user_local_prefs/user_local_prefs_bloc.dart';
import 'package:blavapp/bloc/user_data/user_perms/user_perms_bloc.dart';
import 'package:blavapp/route_generator.dart';
import 'package:blavapp/services/auth_repo.dart';
import 'package:blavapp/services/data_repo.dart';
import 'package:blavapp/services/prefs_repo.dart';
import 'package:blavapp/services/storage_repo.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  BlocOverrides.runZoned(
    () => runApp(const BlavApp()),
    blocObserver: AppBlocObserver(),
  );
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
    // print(transition);
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
              ],
              child: MultiBlocProvider(
                providers: [
                  // User data providers
                  BlocProvider(
                    lazy: false,
                    create: (context) => UserDataBloc(
                      authBloc: context.read<AuthBloc>(),
                      dataRepo: context.read<DataRepo>(),
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
                  BlocProvider(
                    lazy: false,
                    create: (context) => EventFocusBloc(
                      prefs: context.read<PrefsRepo>(),
                      dataRepo: context.read<DataRepo>(),
                    )..add(const EventFocusLoad()),
                  ),
                ],
                child: BlocBuilder<ThemeBloc, ThemeState>(
                  builder: (context, themeState) {
                    return BlocBuilder<LocalizationBloc, LocalizationState>(
                      builder: (context, localizationState) {
                        return BlocBuilder<AuthBloc, AuthState>(
                          builder: (context, authState) {
                            return BlocBuilder<EventFocusBloc, EventFocusState>(
                              builder: (context, eventFocusState) {
                                // bool eventFocused = eventFocusState.status ==
                                //     EventFocusStatus.focused;
                                // Event data providers
                                return MultiBlocProvider(
                                  providers: [
                                    BlocProvider(
                                      create: (context) => CateringBloc(
                                        dataRepo: context.read<DataRepo>(),
                                        eventFocusBloc:
                                            context.read<EventFocusBloc>(),
                                      ),
                                    ),
                                    BlocProvider(
                                      create: (context) => CosplayBloc(
                                        dataRepo: context.read<DataRepo>(),
                                        eventFocusBloc:
                                            context.read<EventFocusBloc>(),
                                      ),
                                    ),
                                    BlocProvider(
                                      create: (context) => DegustationBloc(
                                        dataRepo: context.read<DataRepo>(),
                                        eventFocusBloc:
                                            context.read<EventFocusBloc>(),
                                      ),
                                    ),
                                    BlocProvider(
                                      create: (context) => MapsBloc(
                                        dataRepo: context.read<DataRepo>(),
                                        eventFocusBloc:
                                            context.read<EventFocusBloc>(),
                                      ),
                                    ),
                                    BlocProvider(
                                      create: (context) => ProgrammeBloc(
                                        dataRepo: context.read<DataRepo>(),
                                        eventFocusBloc:
                                            context.read<EventFocusBloc>(),
                                      ),
                                    ),
                                  ],
                                  child: _buildMaterialApp(
                                    context,
                                    themeState,
                                    localizationState,
                                    authState,
                                  ),
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
          return const CircularProgressIndicator();
        }
      },
    );
  }

  Widget _buildMaterialApp(
    BuildContext context,
    ThemeState themeState,
    LocalizationState localizationState,
    AuthState authState,
  ) {
    bool isAuthenticated = authState.status == AuthStatus.authenticated;
    return MaterialApp(
      title: 'BlavApp',
      theme: themeState.themeData,
      locale: localizationState.locale,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      initialRoute: RoutePaths.welcome,
      onGenerateRoute: (settings) => RouteGenerator.generateRoute(
        settings: settings,
        isAuthenticated: isAuthenticated,
        isStaffMember: false, // TODO: load from user permissions
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
