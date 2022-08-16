import 'package:blavapp/components/page_hierarchy/redirect_page.dart';
import 'package:blavapp/views/admin/admin_page.dart';
import 'package:blavapp/views/admin/vote_results.dart';
import 'package:blavapp/views/admin/ticket_validation.dart';
import 'package:blavapp/views/admin/voting_list.dart';
import 'package:blavapp/views/catering/catering_page.dart';
import 'package:blavapp/views/catering/catering_details.dart';
import 'package:blavapp/views/catering/catering_place_details.dart';
import 'package:blavapp/views/contacts/contact_detail.dart';
import 'package:blavapp/views/contacts/contacts_page.dart';
import 'package:blavapp/views/cosplay/cosplay_details.dart';
import 'package:blavapp/views/cosplay/cosplay_page.dart';
import 'package:blavapp/views/degustation/degustation_details.dart';
import 'package:blavapp/views/degustation/degustation_page.dart';
import 'package:blavapp/views/degustation/degustation_place_details.dart';
import 'package:blavapp/views/events/event_details.dart';
import 'package:blavapp/views/events/event_home_page.dart';
import 'package:blavapp/views/events/events_page.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:blavapp/views/maps/maps_page.dart';
import 'package:blavapp/views/profile/profile_delete_page.dart';
import 'package:blavapp/views/profile/profile_page.dart';
import 'package:blavapp/views/profile/profile_tickets.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:blavapp/views/programme/programme_page.dart';
import 'package:blavapp/views/settings/settings_page.dart';
import 'package:blavapp/views/sign_in/password_reset_page.dart';
import 'package:blavapp/views/sign_in/signin_page.dart';
import 'package:blavapp/views/sign_in/signup_page.dart';
import 'package:blavapp/views/story/story_faction_detail.dart';
import 'package:blavapp/views/story/story_pape.dart';
import 'package:blavapp/views/welcome/welcome_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class RoutePaths {
  // UnAuths routes
  static const String signIn = '/signin';
  static const String signInForgottenPassword = '/forgotten-password';
  static const String signUp = '/signup';
  // User routes
  static const String profile = '/profile';
  static const String myTickets = '/my-tickets';
  static const String profileDelete = '/profile/delete';
  // Static routes
  static const String welcome = '/welcome';
  static const String events = '/events';
  static const String eventDetail = '/eventDetail';
  static const String admin = '/admin';
  static const String adminTicketValidation = '/admin/ticket-validation';
  static const String adminVoting = '/admin/voting';
  static const String adminVotingResults = '/admin/voting/results';
  static const String settings = '/setting';
  // Event related route
  static const String eventHome = '/';
  static const String story = '/story';
  static const String storyFaction = '/story/faction';
  static const String programme = '/programme';
  static const String programmeEntry = '/programme/entry';
  static const String catering = '/catering';
  static const String cateringItem = '/catering/item';
  static const String cateringPlace = '/catering/place';
  static const String degustation = '/degustation';
  static const String degustationItem = '/degustation/item';
  static const String degustationPlace = '/degustation/place';
  static const String cosplay = '/cosplay';
  static const String cosplayRecord = '/cosplay/record';
  static const String maps = '/maps';
  static const String mapView = '/map/view';
  static const String contacts = '/contacts';
  static const String contactEntity = '/contacts/entity';
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

      case RoutePaths.signInForgottenPassword:
        return unAuthGuard(
          MaterialPageRoute(
            builder: (_) => const PasswordResetPage(),
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
      case RoutePaths.myTickets:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const ProfileMyTicketsPage(),
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
      // TODO: add admin guard
      case RoutePaths.admin:
        return MaterialPageRoute(
          builder: (_) => const AdminPage(),
        );
      case RoutePaths.adminTicketValidation:
        return MaterialPageRoute(
          builder: (_) => const TicketValidationPage(),
        );
      case RoutePaths.adminVoting:
        return MaterialPageRoute(
          builder: (_) => const VotingPage(),
        );
      case RoutePaths.adminVotingResults:
        final args = settings.arguments! as VoteResultsArguments;
        return MaterialPageRoute(
          builder: (_) => VoteResults(
            voteRef: args.voteRef,
          ),
        );
      case RoutePaths.settings:
        return MaterialPageRoute(
          builder: (_) => const SettingsPage(),
        );
      // Event related route
      case RoutePaths.eventHome:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const EventHomePage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.story:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const StoryPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.storyFaction:
        final args = settings.arguments! as StoryFactionDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => StoryFactionDetail(factionRef: args.factionRef),
          ),
          isAuthenticated,
        );
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
      case RoutePaths.cateringPlace:
        final args = settings.arguments! as CateringPlaceDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => CateringPlaceDetails(place: args.place),
          ),
          isAuthenticated,
        );
      case RoutePaths.degustation:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const DegustationPage(),
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
      case RoutePaths.degustationPlace:
        final args = settings.arguments! as DegustationPlaceDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => DegustationPlaceDetails(place: args.place),
          ),
          isAuthenticated,
        );
      case RoutePaths.cosplay:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const CosplayPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.cosplayRecord:
        final args = settings.arguments! as CosplayDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => CosplayDetails(record: args.record),
          ),
          isAuthenticated,
        );

      case RoutePaths.contacts:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const ContactsPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.contactEntity:
        final args = settings.arguments! as ContactDetailsArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => ContactDetails(entityRef: args.entityRef),
          ),
          isAuthenticated,
        );
      // case RoutePaths.divisions:
      //   return authGuard(MaterialPageRoute(builder: (_) => DivisionsPage(),), isAuthenticated,);
      case RoutePaths.maps:
        return authGuard(
          MaterialPageRoute(
            builder: (_) => const MapsPage(),
          ),
          isAuthenticated,
        );
      case RoutePaths.mapView:
        final args = settings.arguments! as MapViewArguments;
        return authGuard(
          MaterialPageRoute(
            builder: (_) => MapViewPage(
              mapRef: args.mapRef,
              pointRefZoom: args.pointRefZoom,
            ),
          ),
          isAuthenticated,
        );
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
          titleText: AppLocalizations.of(context)!.contSignInRedirectTitle,
          redirectMessage: AppLocalizations.of(context)!.contSignInRedirectText,
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
          titleText: AppLocalizations.of(context)!.contProfileRedirectTitle,
          redirectMessage:
              AppLocalizations.of(context)!.contProfileRedirectText,
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
