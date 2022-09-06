import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/contacts.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/model/story.dart';
import 'package:blavapp/model/support_ticket.dart';
import 'package:blavapp/model/ticket.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:blavapp/model/user_perms.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepo {
  DataRepo() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  // User permissions
  //////////////////////////////////////////////////////////////////////////////
  final CollectionReference _userPermsCollectionRef = FirebaseFirestore.instance
      .collection('user_perms')
      .withConverter<UserPerms>(
        fromFirestore: (snapshot, _) => UserPerms.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Future<UserPerms> getUserPerms(String userUID) {
    return _userPermsCollectionRef
        .doc(userUID)
        .get()
        .then((value) => value.data()! as UserPerms);
  }
  //////////////////////////////////////////////////////////////////////////////
  // User data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _userDataCollectionRef = FirebaseFirestore.instance
      .collection('user_data')
      .withConverter<UserData>(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  void initUserData(String uid, UserData appUser) {
    _userDataCollectionRef.doc(uid).set(appUser);
  }

  Future<UserData> getUserData(String userUID) {
    return _userDataCollectionRef
        .doc(userUID)
        .get()
        .then((value) => value.data()! as UserData);
  }

  Stream<UserData> getUserDataStream(String userUID) {
    return _userDataCollectionRef
        .doc(userUID)
        .snapshots(includeMetadataChanges: true)
        .map((value) => value.data()! as UserData);
  }

  Future<void> addMyProgrammeEntry(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'myProgramme': FieldValue.arrayUnion([entryID])
    });
  }

  Future<void> removeMyProgrammeEntry(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'myProgramme': FieldValue.arrayRemove([entryID])
    });
  }

  Future<void> addProgrammeEntryNotification(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'myNotifications': FieldValue.arrayUnion([entryID])
    });
  }

  Future<void> removeProgrammeEntryNotification(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'myNotifications': FieldValue.arrayRemove([entryID])
    });
  }

  Future<void> addDegustationFavorite(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'favoriteSamples': FieldValue.arrayUnion([entryID])
    });
  }

  Future<void> removeDegustationFavorite(
    String userUID,
    String entryID,
  ) {
    return _userDataCollectionRef.doc(userUID).update({
      'favoriteSamples': FieldValue.arrayRemove([entryID])
    });
  }

  Future<void> setUserRating({
    required String userUID,
    required String itemRef,
    required double rating,
  }) {
    return _userDataCollectionRef
        .doc(userUID)
        .update({'myRatings.$itemRef': rating});
  }

  Future<void> setUserVote({
    required String userUID,
    required String cosplayRef,
    required bool? vote,
  }) {
    return _userDataCollectionRef
        .doc(userUID)
        .update({'myVoting.$cosplayRef': vote});
  }

  Future<void> addSupportTicket({
    required String userUID,
    required String ticketRef,
  }) {
    return _userDataCollectionRef.doc(userUID).update({
      'supTickets': FieldValue.arrayUnion([ticketRef])
    });
  }

  Future<void> removeSupportTicket({
    required String userUID,
    required String ticketRef,
  }) {
    return _userDataCollectionRef.doc(userUID).update({
      'supTickets': FieldValue.arrayRemove([ticketRef])
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Events
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _eventsCollectionRef =
      FirebaseFirestore.instance.collection('events').withConverter<Event>(
            fromFirestore: (snapshot, _) => Event.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson(),
          );

  Future<List<Event>> getEvents() async {
    final List<Event> events = await _eventsCollectionRef.get().then(
          (snapshot) =>
              snapshot.docs.map((doc) => doc.data()! as Event).toList(),
        );
    return events;
  }

  Stream<Event> getEventStream(String eventTag) {
    return _eventsCollectionRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Event');
      }
      return ((snapshot.data() as Event));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Tickets
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _ticketsCollectionRef = FirebaseFirestore.instance
      .collection('admin_tickets')
      .withConverter<Ticket>(
        fromFirestore: (snapshot, _) => Ticket.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Future<Ticket> getTicket(String ticketId) {
    return _ticketsCollectionRef.doc(ticketId).get().then((value) {
      if (value.data() == null) {
        throw NullDataException('$ticketId:tickets');
      }
      return value.data() as Ticket;
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Catering data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _cateringDataRef = FirebaseFirestore.instance
      .collection('data_catering')
      .withConverter<Catering>(
        fromFirestore: (snapshot, _) => Catering.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Stream<Catering> getCateringStream(String eventTag) {
    return _cateringDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Catering');
      }
      return ((snapshot.data() as Catering));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Degustation data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _degustationDataRef = FirebaseFirestore.instance
      .collection('data_degustation')
      .withConverter<Degustation>(
        fromFirestore: (snapshot, _) => Degustation.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Stream<Degustation> getDegustationStream(String eventTag) {
    return _degustationDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Degustation');
      }
      return ((snapshot.data() as Degustation));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Programme data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _programmeDataRef = FirebaseFirestore.instance
      .collection('data_programme')
      .withConverter<Programme>(
        fromFirestore: (snapshot, _) => Programme.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Stream<Programme> getProgrammeStream(String eventTag) {
    return _programmeDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Programme');
      }
      return ((snapshot.data() as Programme));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Maps data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _mapsDataRef =
      FirebaseFirestore.instance.collection('data_maps').withConverter<Maps>(
            fromFirestore: (snapshot, _) => Maps.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson(),
          );

  Stream<Maps> getMapsStream(String eventTag) {
    return _mapsDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Maps');
      }
      return ((snapshot.data() as Maps));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Contacts data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _contactsDataRef = FirebaseFirestore.instance
      .collection('data_contacts')
      .withConverter<Contacts>(
        fromFirestore: (snapshot, _) => Contacts.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Stream<Contacts> getContactsStream(String eventTag) {
    return _contactsDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Contacts');
      }
      return ((snapshot.data() as Contacts));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Cosplay data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _cosplayDataRef = FirebaseFirestore.instance
      .collection('data_cosplay')
      .withConverter<Cosplay>(
        fromFirestore: (snapshot, _) => Cosplay.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Stream<Cosplay> getCosplayStream(String eventTag) {
    return _cosplayDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Cosplay');
      }
      return ((snapshot.data() as Cosplay));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Story data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _storyDataRef =
      FirebaseFirestore.instance.collection('data_story').withConverter<Story>(
            fromFirestore: (snapshot, _) => Story.fromJson(snapshot.data()!),
            toFirestore: (entry, _) => entry.toJson(),
          );

  Stream<Story> getStoryStream(String eventTag) {
    return _storyDataRef.doc(eventTag).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventTag:Story');
      }
      return ((snapshot.data() as Story));
    });
  }

  //////////////////////////////////////////////////////////////////////////////
  // Support data - Voting
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _votingDataRef =
      FirebaseFirestore.instance.collection('sup_voting');

  Stream<Map<String, dynamic>> getVotingStream(String eventRef) {
    return _votingDataRef
        .doc(eventRef)
        .snapshots(includeMetadataChanges: true)
        .map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$eventRef:Voting');
      }
      return snapshot.data()! as Map<String, dynamic>;
    });
  }

  Future<void> addVote({
    required String eventRef,
    required String voteRef,
    required String cosplayRef,
    required String userUID,
    required bool? vote,
  }) {
    try {
      return _votingDataRef
          .doc(eventRef)
          .update({'$voteRef.$cosplayRef.$userUID': vote});
    } catch (e) {
      throw DocUpdateException(
        '$voteRef.$cosplayRef.$userUID',
        e.toString(),
      );
    }
  }

  //////////////////////////////////////////////////////////////////////////////
  // Support data - Rating
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _ratingDataRef =
      FirebaseFirestore.instance.collection('sup_rating');

  Future<void> addRating({
    required String eventRef,
    required String userUID,
    required String itemRef,
    required double rating,
  }) {
    return _ratingDataRef.doc(eventRef).update({
      itemRef: {userUID: rating}
    });
  }

//////////////////////////////////////////////////////////////////////////////
// Support data - Feedback
//////////////////////////////////////////////////////////////////////////////

  final CollectionReference _reviewDataRef =
      FirebaseFirestore.instance.collection('sup_feedback');

  Future<void> addReview({
    required String eventRef,
    required String reference,
    required double rating,
    required String review,
  }) {
    return _reviewDataRef.doc(eventRef).update({
      reference: FieldValue.arrayUnion([
        {
          'rating': rating,
          'review': review,
        }
      ]),
    });
  }

//////////////////////////////////////////////////////////////////////////////
// Support tickets
//////////////////////////////////////////////////////////////////////////////

  final CollectionReference _supTicketsRef = FirebaseFirestore.instance
      .collection('sup_tickets')
      .withConverter<SupportTicket>(
        fromFirestore: (snapshot, _) =>
            SupportTicket.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  Future<String> initSuportTicket({
    required SupportTicket ticket,
  }) async {
    DocumentReference ticketRef = await _supTicketsRef.add(ticket);
    return ticketRef.id;
  }

  Stream<SupportTicket> getSupportTicketStream({
    required String ticketRef,
  }) {
    return _supTicketsRef.doc(ticketRef).snapshots().map((snapshot) {
      if (snapshot.data() == null) {
        throw NullDataException('$ticketRef:SupportTicket');
      }
      return ((snapshot.data() as SupportTicket));
    });
  }
}

//////////////////////////////////////////////////////////////////////////////
// Exceptions
//////////////////////////////////////////////////////////////////////////////

class NullDataException implements Exception {
  final String message;

  NullDataException(this.message);

  @override
  String toString() {
    return 'DocUpdateException: $message';
  }
}

class DocUpdateException implements Exception {
  final String docPath;
  final String message;

  DocUpdateException(this.docPath, this.message);

  @override
  String toString() {
    return 'DocUpdateException: $docPath: $message';
  }
}

class AppFirebaseException implements Exception {
  final String docPath;
  final String code;
  final String message;

  AppFirebaseException(this.docPath, FirebaseException e)
      : code = e.code,
        message = e.message ?? '';

  @override
  String toString() {
    return 'FirebaseException: $docPath: ($code) $message';
  }
}
