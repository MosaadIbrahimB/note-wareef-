import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FireBaseStoreControl {
  static Future<String> upload(
      {required File file, required String name}) async {
    var storageRef = FirebaseStorage.instance.ref().child(name);

    await storageRef.putFile(file);
    return await storageRef.getDownloadURL();
  }






}
