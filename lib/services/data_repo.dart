import 'package:blavapp/model/cater_item.dart';
import 'package:blavapp/model/degus_item.dart';
import 'package:blavapp/model/event.dart';
import 'package:blavapp/model/prog_entry.dart';
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

  final CollectionReference _appUserDataCollectionRef =
      FirebaseFirestore.instance.collection('users').withConverter<UserData>(
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

  //////////////////////////////////////////////////////////////////////////////
  // Catering data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _cateringDataRef =
      FirebaseFirestore.instance.collection('data_catering');

  final CollectionReference _degustationDataRef =
      FirebaseFirestore.instance.collection('data_degustation');

  Future<List<CaterItem>> getCaterItems(String eventID) async {
    final List<CaterItem> caterItems =
        await _cateringDataRef.doc(eventID).get().then(
              (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                      as List<dynamic>)
                  .map(
                    (item) => CaterItem.fromJson(item as Map<String, dynamic>),
                  )
                  .toList(),
            );
    return caterItems;
  }

  Stream<List<CaterItem>> getCaterItemsStream(String eventTag) {
    return _cateringDataRef.doc(eventTag).snapshots().map(
          (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                  as List<dynamic>)
              .map(
                (item) => CaterItem.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  Future<List<DegusItem>> getDegusItems(String eventID) async {
    final List<DegusItem> degusItems =
        await _degustationDataRef.doc(eventID).get().then(
              (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                      as List<dynamic>)
                  .map(
                    (item) => DegusItem.fromJson(item as Map<String, dynamic>),
                  )
                  .toList(),
            );
    return degusItems;
  }

  Stream<List<DegusItem>> getDegusItemsStream(String eventTag) {
    return _degustationDataRef.doc(eventTag).snapshots().map(
          (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                  as List<dynamic>)
              .map(
                (item) => DegusItem.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
  }

  //////////////////////////////////////////////////////////////////////////////
  // Catering data
  //////////////////////////////////////////////////////////////////////////////

  final CollectionReference _programmeDataRef =
      FirebaseFirestore.instance.collection('data_programme');

  Future<List<ProgEntry>> getProgItems(String eventID) async {
    final List<ProgEntry> caterItems =
        await _programmeDataRef.doc(eventID).get().then(
              (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                      as List<dynamic>)
                  .map(
                    (item) => ProgEntry.fromJson(item as Map<String, dynamic>),
                  )
                  .toList(),
            );
    return caterItems;
  }

  Stream<List<ProgEntry>> getProgItemsStream(String eventTag) {
    return _programmeDataRef.doc(eventTag).snapshots().map(
          (snapshot) => ((snapshot.data() as Map<String, dynamic>)['items']
                  as List<dynamic>)
              .map(
                (item) => ProgEntry.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
        );
  }
}
