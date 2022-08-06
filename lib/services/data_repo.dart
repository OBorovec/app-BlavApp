import 'package:blavapp/model/catering.dart';
import 'package:blavapp/model/cosplay.dart';
import 'package:blavapp/model/degustation.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/maps.dart';
import 'package:blavapp/model/programme.dart';
import 'package:blavapp/model/user_data.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DataRepo {
  DataRepo() {
    FirebaseFirestore.instance.settings = const Settings(
      persistenceEnabled: true,
      cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
    );
  }

  //////////////////////////////////////////////////////////////////////////////
  // User data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _appUserDataCollectionRef = FirebaseFirestore
      .instance
      .collection('user_data')
      .withConverter<UserData>(
        fromFirestore: (snapshot, _) => UserData.fromJson(snapshot.data()!),
        toFirestore: (entry, _) => entry.toJson(),
      );

  void initUserData(String uid, UserData appUser) {
    _appUserDataCollectionRef.doc(uid).set(appUser);
  }

  Future<UserData> getUserData(String userUID) {
    return _appUserDataCollectionRef
        .doc(userUID)
        .get()
        .then((value) => value.data()! as UserData);
  }

  Stream<UserData> getUserDataStream(String userUID) {
    return _appUserDataCollectionRef
        .doc(userUID)
        .snapshots(includeMetadataChanges: true)
        .map((value) => value.data()! as UserData);
  }

  Future<void> addMyProgrammeEntry(
    String userUID,
    String entryID,
  ) {
    return _appUserDataCollectionRef.doc(userUID).update({
      'myProgramme': FieldValue.arrayUnion([entryID])
    });
  }

  Future<void> removeMyProgrammeEntry(
    String userUID,
    String entryID,
  ) {
    return _appUserDataCollectionRef.doc(userUID).update({
      'myProgramme': FieldValue.arrayRemove([entryID])
    });
  }

  Future<void> addProgrammeEntryNotification(
    String userUID,
    String entryID,
  ) {
    return _appUserDataCollectionRef.doc(userUID).update({
      'myNotifications': FieldValue.arrayUnion([entryID])
    });
  }

  Future<void> removeProgrammeEntryNotification(
    String userUID,
    String entryID,
  ) {
    return _appUserDataCollectionRef.doc(userUID).update({
      'myNotifications': FieldValue.arrayRemove([entryID])
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

  Future<Event> getEvent(String eventID) {
    return _eventsCollectionRef
        .doc(eventID)
        .get()
        .then((value) => value.data()! as Event);
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
}

//////////////////////////////////////////////////////////////////////////////
// Exceptions
//////////////////////////////////////////////////////////////////////////////

class NullDataException implements Exception {
  final String message;

  NullDataException(this.message);
}
