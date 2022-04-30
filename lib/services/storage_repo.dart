import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class StorageRepo {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  // User Profile image

  String _userProfileImagePath(String userUID) {
    return 'user/$userUID';
  }

  Future<String> getUserProfileImage(String userUID) async {
    return _storage.ref(_userProfileImagePath(userUID)).getDownloadURL();
  }

  Future<String> uploadFile(String userUID, File file) async {
    final Reference storageRef = _storage.ref(_userProfileImagePath(userUID));
    await storageRef.putFile(file);
    return storageRef.getDownloadURL();
  }

  Future<String> getObjectURL(String gsURL) async {
    return _storage.refFromURL(gsURL).getDownloadURL();
  }
}
