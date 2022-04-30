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
}
