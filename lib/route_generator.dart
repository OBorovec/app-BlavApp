import 'package:blavapp/components/_pages/redirect_page.dart';
import 'package:blavapp/views/catering/catering_page.dart';
import 'package:blavapp/views/catering/catering_details.dart';
import 'package:blavapp/views/catering/degustation_details.dart';
import 'package:blavapp/views/gwint_club/gwint_club_page.dart';
import 'package:blavapp/views/gwint_events/event_details.dart';
import 'package:blavapp/views/gwint_events/events_page.dart';
import 'package:blavapp/views/profile/profile_delete_page.dart';
import 'package:blavapp/views/profile/profile_page.dart';
import 'package:blavapp/views/programme/programe_details.dart';
import 'package:blavapp/views/programme/programme_page.dart';
import 'package:blavapp/views/settings/settings_page.dart';
import 'package:blavapp/views/sign_in/signin_page.dart';
import 'package:blavapp/views/sign_in/signup_page.dart';
import 'package:blavapp/views/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutePaths {
  // UnAuths routes
  static const String signIn = '/signin';
  static const String signUp = '/signup';
  // User routes
  static const String profile = '/profile';
  static const String profileDelete = '/profile/delete';
  // Static routes
  static const String welcome = '/welcome';
  static const String gwint = '/gwintclub';
  static const String events = '/events';
  static const String eventDetail = '/eventDetail';
  static const String settings = '/setting';
  // Event related route
  static const String eventHome = '/';
  static const String programme = '/programme';
  static const String programmeEntry = '/programme-entry';
  static const String catering = '/catering';
  static const String cateringItem = '/catering-item';
  static const String degustationItem = '/degustation-item';
  static const String cosplay = '/cosplay';
  static const String divisions = '/divisions';
  static const String maps = '/maps';
}

class RouteGenerator {
  static Route<dynamic> generateRoute({
    required RouteSettings settings,
    required bool isAuthenticated,
    required bool isStaffMember,
  }) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      // User routes
      case RoutePaths.signUp:
        return unAuthGuard(
          MaterialPageRoute(
            builder: (_) => const SignUpPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.signIn:
        return unAuthGuard(
          MaterialPageRoute(
            builder: (_) => const SignInPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.profile:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const UserProfilePage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.profileDelete:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const UserProfileDeletePage(),
          ),
          isAuthenticated,
        );
      // Static routes
      case RoutePaths.welcome:
        return MaterialPageRoute(
          builder: (_) => const WelcomePage(),
        );
      case RoutePaths.gwint:
        return authGuard(
            MaterialPageRoute(
              builder: (_) => const GwintHomePage(),
            ),
            isAuthenticated);
      case RoutePaths.events:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const EventsPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.eventDetail:
        final args = settings.arguments! as EventDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => EventDetails(event: args.event),
          ),
          isAuthenticated,
        );
      case RoutePaths.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      // Event related route
      case RoutePaths.programme:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const ProgrammePage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.programmeEntry:
        final args = settings.arguments! as ProgrammeDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => ProgrammeDetails(entry: args.entry),
          ),
          isAuthenticated,
        );
      case RoutePaths.catering:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const CateringPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.cateringItem:
        final args = settings.arguments! as CateringDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => CateringDetails(item: args.item),
          ),
          isAuthenticated,
        );
      case RoutePaths.degustationItem:
        final args = settings.arguments! as DegustationDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => DegustationDetails(item: args.item),
          ),
          isAuthenticated,
        );
      // case RoutePaths.cosplay:
      //   return authGuard(MaterialPageRoute(builder: (_) => CosplayPage(),), isAuthenticated,);
      // case RoutePaths.divisions:
      //   return authGuard(MaterialPageRoute(builder: (_) => DivisionsPage(),), isAuthenticated,);
      // case RoutePaths.maps:
      //   return authGuard(MaterialPageRoute(builder: (_) => MapsPage(),), isAuthenticated,);
      default:
        return _errorRoute(
          settings.name,
          isAuthenticated,
          isStaffMember,
        );
    }
  }

  static MaterialPageRoute authGuard(
    MaterialPageRoute route,
    isAuthenticated,
  ) {
    if (!isAuthenticated) {
      return MaterialPageRoute(
        builder: (context) => RedirectPage(
          titleText: AppLocalizations.of(context)!.signInRedirectTitle,
          redirectMessage: AppLocalizations.of(context)!.signInRedirectText,
          route: RoutePaths.signIn,
        ),
      );
    }
    return route;
  }

  static MaterialPageRoute unAuthGuard(
    MaterialPageRoute route,
    isAuthenticated,
  ) {
    if (isAuthenticated) {
      return MaterialPageRoute(
        builder: (context) => RedirectPage(
          titleText: AppLocalizations.of(context)!.profRedirectTitle,
          redirectMessage: AppLocalizations.of(context)!.profRedirectText,
          route: RoutePaths.profile,
        ),
      );
    }
    return route;
  }

  static Route<dynamic> _errorRoute(
    String? route,
    bool isAuthenticated,
    bool isStaffMember,
  ) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('404'),
              Text('Route: ${route ?? 'null'}'),
              Text('Auth: $isAuthenticated'),
              Text('Staff: $isStaffMember'),
            ],
          ),
        ),
      );
    });
  }
}
