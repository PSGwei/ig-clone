import 'dart:typed_data';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseAuth userAuth = FirebaseAuth.instance;

  Future<String> storeImage(
      String childName, Uint8List imageFile, bool isPost) async {
    //creates a reference(pointer) to a location( a file or a directory) within Firebase Storage,
    // allowing to access or modify it.
    Reference ref =
        firebaseStorage.ref().child(childName).child(userAuth.currentUser!.uid);

    // upload image
    UploadTask uploadTask = ref.putData(imageFile);
    // can perform some functions on uploadtask such as then(), whenComplete()...
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }
}
