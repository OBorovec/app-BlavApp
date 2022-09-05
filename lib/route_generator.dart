import 'package:blavapp/components/page_content/restrict_auth.dart';
import 'package:blavapp/components/page_content/restrict_no_event.dart';
import 'package:blavapp/components/page_content/restrict_non_staff.dart';
import 'package:blavapp/components/page_content/restrict_unauth.dart';
import 'package:blavapp/views/admin/admin_page.dart';
import 'package:blavapp/views/admin/vote_results.dart';
import 'package:blavapp/views/admin/ticket_validation.dart';
import 'package:blavapp/views/admin/voting_list.dart';
import 'package:blavapp/views/catering/catering_page.dart';
import 'package:blavapp/views/catering/catering_place_details.dart';
import 'package:blavapp/views/contacts/contact_detail.dart';
import 'package:blavapp/views/contacts/contacts_page.dart';
import 'package:blavapp/views/cosplay/cosplay_details.dart';
import 'package:blavapp/views/cosplay/cosplay_page.dart';
import 'package:blavapp/views/degustation/degustation_details.dart';
import 'package:blavapp/views/degustation/degustation_page.dart';
import 'package:blavapp/views/degustation/degustation_place_details.dart';
import 'package:blavapp/views/development/development_page.dart';
import 'package:blavapp/views/events/event_details.dart';
import 'package:blavapp/views/events/event_home_page.dart';
import 'package:blavapp/views/events/events_page.dart';
import 'package:blavapp/views/maps/map_view_page.dart';
import 'package:blavapp/views/maps/maps_page.dart';
import 'package:blavapp/views/profile/profile_delete_page.dart';
import 'package:blavapp/views/profile/profile_page.dart';
import 'package:blavapp/views/profile/profile_support_tickets.dart';
import 'package:blavapp/views/profile/profile_tickets.dart';
import 'package:blavapp/views/programme/programme_details.dart';
import 'package:blavapp/views/programme/programme_page.dart';
import 'package:blavapp/views/settings/settings_page.dart';
import 'package:blavapp/views/sign_in/password_reset_page.dart';
import 'package:blavapp/views/sign_in/signin_page.dart';
import 'package:blavapp/views/sign_in/signup_page.dart';
import 'package:blavapp/views/story/story_faction_detail.dart';
import 'package:blavapp/views/story/story_page.dart';
import 'package:blavapp/views/welcome/welcome_page.dart';
import 'package:flutter/material.dart';

class RoutePaths {
  // UnAuths routes
  static const String signIn = '/signin';
  static const String signInForgottenPassword = '/forgotten-password';
  static const String signUp = '/signup';
  // User routes
  static const String profile = '/profile';
  static const String myTickets = '/profile/my-tickets';
  static const String mySupportTickets = '/profile/support-tickets';
  static const String profileDelete = '/profile/delete';
  // Static routes
  static const String welcome = '/';
  static const String events = '/events';
  static const String eventDetail = '/eventDetail';
  static const String admin = '/admin';
  static const String adminTicketValidation = '/admin/ticket-validation';
  static const String adminVoting = '/admin/voting';
  static const String adminVotingResults = '/admin/voting/results';
  static const String development = '/development';
  static const String settings = '/setting';
  // Event related route
  static const String eventHome = '/event';
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

const List<String> allPaths = [
  RoutePaths.signIn,
  RoutePaths.signInForgottenPassword,
  RoutePaths.signUp,
  RoutePaths.profile,
  RoutePaths.myTickets,
  RoutePaths.profileDelete,
  RoutePaths.welcome,
  RoutePaths.events,
  RoutePaths.eventDetail,
  RoutePaths.admin,
  RoutePaths.adminTicketValidation,
  RoutePaths.adminVoting,
  RoutePaths.adminVotingResults,
  RoutePaths.development,
  RoutePaths.settings,
  RoutePaths.eventHome,
  RoutePaths.story,
  RoutePaths.storyFaction,
  RoutePaths.programme,
  RoutePaths.programmeEntry,
  RoutePaths.catering,
  RoutePaths.cateringItem,
  RoutePaths.cateringPlace,
  RoutePaths.degustation,
  RoutePaths.degustationItem,
  RoutePaths.degustationPlace,
  RoutePaths.cosplay,
  RoutePaths.cosplayRecord,
  RoutePaths.maps,
  RoutePaths.mapView,
  RoutePaths.contacts,
  RoutePaths.contactEntity,
];

const List<String> eventPaths = [
  RoutePaths.eventHome,
  RoutePaths.story,
  RoutePaths.storyFaction,
  RoutePaths.programme,
  RoutePaths.programmeEntry,
  RoutePaths.catering,
  RoutePaths.cateringItem,
  RoutePaths.cateringPlace,
  RoutePaths.degustation,
  RoutePaths.degustationItem,
  RoutePaths.degustationPlace,
  RoutePaths.cosplay,
  RoutePaths.cosplayRecord,
  RoutePaths.maps,
  RoutePaths.mapView,
  RoutePaths.contacts,
  RoutePaths.contactEntity,
];

const List<String> staffPaths = [
  RoutePaths.admin,
  RoutePaths.adminTicketValidation,
  RoutePaths.adminVoting,
  RoutePaths.adminVotingResults,
];

class RouteGenerator {
  static Route<dynamic> generateRoute({
    required RouteSettings settings,
    required bool isAuthenticated,
    required bool hasEvent,
    required bool isAdmin,
    required bool isStaffMember,
  }) {
    // Getting arguments passed in while calling Navigator.pushNamed
    // final args = settings.arguments;
    debugPrint('--- Navigating to ${settings.name} ---');
    // Path with no restrictions
    if (allPaths.contains(settings.name)) {
      switch (settings.name) {
        case RoutePaths.welcome:
          return MaterialPageRoute(
            builder: (_) => const WelcomePage(),
          );
        case RoutePaths.development:
          return MaterialPageRoute(
            builder: (_) => const DevelopmentPage(),
          );
      }
      if (isAuthenticated) {
        // Paths only accessible to authenticated users
        switch (settings.name) {
          case RoutePaths.profile:
            return MaterialPageRoute(
              builder: (_) => const UserProfilePage(),
            );
          case RoutePaths.myTickets:
            return MaterialPageRoute(
              builder: (_) => const ProfileMyTicketsPage(),
            );
          case RoutePaths.mySupportTickets:
            return MaterialPageRoute(
              builder: (_) => const ProfileMySupportTicketsPage(),
            );
          case RoutePaths.profileDelete:
            return MaterialPageRoute(
              builder: (_) => const UserProfileDeletePage(),
            );
          case RoutePaths.events:
            return MaterialPageRoute(
              builder: (_) => const EventsPage(),
            );
          case RoutePaths.eventDetail:
            final args = settings.arguments! as EventDetailsArguments;
            return MaterialPageRoute(
              builder: (_) => EventDetails(event: args.event),
            );
          case RoutePaths.settings:
            return MaterialPageRoute(
              builder: (_) => const SettingsPage(),
            );
          // Restriction if accessing unauth routes while authenticated
          case RoutePaths.signUp:
          case RoutePaths.signIn:
          case RoutePaths.signInForgottenPassword:
            return MaterialPageRoute(
              builder: (_) => const RestrictAuth(),
            );
        }
        if (eventPaths.contains(settings.name)) {
          if (hasEvent) {
            // Paths only accessible to authenticated users with an event
            switch (settings.name) {
              case RoutePaths.eventHome:
                return MaterialPageRoute(
                  builder: (_) => const EventHomePage(),
                );
              case RoutePaths.story:
                return MaterialPageRoute(
                  builder: (_) => const StoryPage(),
                );
              case RoutePaths.storyFaction:
                final args =
                    settings.arguments! as StoryFactionDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) =>
                      StoryFactionDetail(factionRef: args.factionRef),
                );
              case RoutePaths.programme:
                return MaterialPageRoute(
                  builder: (_) => const ProgrammePage(),
                );
              case RoutePaths.programmeEntry:
                final args = settings.arguments! as ProgrammeDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => ProgrammeDetails(entry: args.entry),
                );
              case RoutePaths.catering:
                return MaterialPageRoute(
                  builder: (_) => const CateringPage(),
                );
              case RoutePaths.cateringPlace:
                final args =
                    settings.arguments! as CateringPlaceDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => CateringPlaceDetails(place: args.place),
                );
              case RoutePaths.degustation:
                return MaterialPageRoute(
                  builder: (_) => const DegustationPage(),
                );
              case RoutePaths.degustationItem:
                final args = settings.arguments! as DegustationDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => DegustationDetails(item: args.item),
                );
              case RoutePaths.degustationPlace:
                final args =
                    settings.arguments! as DegustationPlaceDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => DegustationPlaceDetails(place: args.place),
                );
              case RoutePaths.cosplay:
                return MaterialPageRoute(
                  builder: (_) => const CosplayPage(),
                );
              case RoutePaths.cosplayRecord:
                final args = settings.arguments! as CosplayDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => CosplayDetails(record: args.record),
                );
              case RoutePaths.contacts:
                return MaterialPageRoute(
                  builder: (_) => const ContactsPage(),
                );
              case RoutePaths.contactEntity:
                final args = settings.arguments! as ContactDetailsArguments;
                return MaterialPageRoute(
                  builder: (_) => ContactDetails(entityRef: args.entityRef),
                );
              case RoutePaths.maps:
                return MaterialPageRoute(
                  builder: (_) => const MapsPage(),
                );
              case RoutePaths.mapView:
                final args = settings.arguments! as MapViewArguments;
                return MaterialPageRoute(
                  builder: (_) => MapViewPage(
                    mapRef: args.mapRef,
                    pointRefZoom: args.pointRefZoom,
                  ),
                );
            }
          } else {
            // Restiction if accessing event paths without an event
            return MaterialPageRoute(
              builder: (_) => const RestrictNoEvent(),
            );
          }
        }
        if (staffPaths.contains(settings.name)) {
          if (isAdmin) {
            // Paths only accessible to authenticated admin users
            switch (settings.name) {
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
            }
          } else {
            return MaterialPageRoute(
              builder: (_) => const RestrictNonStaff(),
            );
          }
        }
      } else {
        // Path only accessible to unauthenticated users
        switch (settings.name) {
          case RoutePaths.signUp:
            return MaterialPageRoute(
              builder: (_) => const SignUpPage(),
            );
          case RoutePaths.signIn:
            return MaterialPageRoute(
              builder: (_) => const SignInPage(),
            );
          case RoutePaths.signInForgottenPassword:
            return MaterialPageRoute(
              builder: (_) => const PasswordResetPage(),
            );
          default:
            if (!allPaths.contains(settings.name)) {
              return MaterialPageRoute(
                builder: (_) => const RestrictUnauth(),
              );
            }
        }
      }
    }
    return _errorRoute(
      settings.name,
      isAuthenticated,
      isStaffMember,
    );
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
