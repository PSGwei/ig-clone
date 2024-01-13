import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:instagram_clone/models/post.dart';
import 'package:uuid/uuid.dart';

final Uuid _uuid = Uuid();

class StorageMethods {
  final FirebaseStorage firebaseStorage = FirebaseStorage.instance;
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth userAuth = FirebaseAuth.instance;

  Future<String> uploadImageToStorage(
      String childName, Uint8List imageFile, bool isPost) async {
    //creates a reference(pointer) to a location( a file or a directory) within Firebase Storage,
    // allowing to access or modify it.
    Reference ref =
        firebaseStorage.ref().child(childName).child(userAuth.currentUser!.uid);

    if (isPost) {
      String id = _uuid.v1();
      ref.child(id);
    }

    // upload image
    UploadTask uploadTask = ref.putData(imageFile);
    // can perform some functions on uploadtask such as then(), whenComplete()...
    TaskSnapshot snapshot = await uploadTask;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return downloadURL;
  }

  Future<String> uploadPost(
    String description,
    Uint8List imageFile,
    String uid,
    String username,
    String profileImage,
  ) async {
    String result = 'Something went wrong';

    try {
      String photoURL = await uploadImageToStorage('posts', imageFile, true);
      String postID = _uuid.v1();
      Post post = Post(
        description: description,
        uid: uid,
        username: username,
        likes: [],
        postId: postID,
        datePublished: DateTime.now(),
        photoURL: photoURL,
        profImage: profileImage,
      );

      await firebaseFirestore
          .collection('posts')
          .doc(postID)
          .set(post.toJson());
    } catch (error) {
      result = error.toString();
    }

    result = 'Success';

    return result;
  }
}
