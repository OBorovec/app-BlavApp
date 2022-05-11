import 'package:blavapp/views/event/event_home_page.dart';
import 'package:blavapp/views/gwint_club/gwint_club.dart';
import 'package:blavapp/views/profile/profile_page.dart';
import 'package:blavapp/views/profile/signin_page.dart';
import 'package:blavapp/views/profile/signup_page.dart';
import 'package:blavapp/views/settings/settings_page.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  // User routes
  static const String profile = '/profile';
  static const String registration = '/registration';
  // Static routes
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
  static const String degustation = '/degustation';
  static const String degustationItem = '/degustation-item';
  static const String cosplay = '/cosplay';
  static const String divisions = '/divisions';
  static const String maps = '/maps';
}

class RouteGenerator {
  static Route<dynamic> generateRoute(
    RouteSettings settings,
    bool isAuthenticated,
    bool isStaffMember,
  ) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    switch (settings.name) {
      // User routes
      case RoutePaths.profile:
        if (isAuthenticated) {
          return MaterialPageRoute(builder: (_) => const UserProfilePage());
        } else {
          return MaterialPageRoute(builder: (_) => const SignInPage());
        }
      case RoutePaths.registration:
        return MaterialPageRoute(builder: (_) => const SignUpPage());
      // Static routes
      case RoutePaths.gwint:
        return MaterialPageRoute(builder: (_) => const GwintHomePage());
      // case RoutePaths.events:
      //   return MaterialPageRoute(builder: (_) => EventsPage());
      // case RoutePaths.eventDetail:
      //   return MaterialPageRoute(builder: (_) => EventDetailPage());
      case RoutePaths.settings:
        return MaterialPageRoute(builder: (_) => const SettingsPage());
      // Event related route
      case RoutePaths.eventHome:
        return MaterialPageRoute(builder: (_) => const EventHomePage());
      // case RoutePaths.programme:
      //   return MaterialPageRoute(builder: (_) => ProgrammePage());
      // case RoutePaths.catering:
      //   return MaterialPageRoute(builder: (_) => CateringPage());
      // case RoutePaths.degustation:
      //   return MaterialPageRoute(builder: (_) => DegustationPage());
      // case RoutePaths.cosplay:
      //   return MaterialPageRoute(builder: (_) => CosplayPage());
      // case RoutePaths.divisions:
      //   return MaterialPageRoute(builder: (_) => DivisionsPage());
      // case RoutePaths.maps:
      //   return MaterialPageRoute(builder: (_) => MapsPage());
      // Default
      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: const Center(
          child: Text('404'),
        ),
      );
    });
  }
}
