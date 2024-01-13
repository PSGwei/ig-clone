import 'dart:typed_data';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:instagram_clone/utilities/methods/storage_methods.dart';
import 'package:instagram_clone/models/user.dart' as models;

class AuthMethods {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  String result = "Something went wrong";

  Future<String> signUp({
    required String email,
    required String password,
    required String username,
    required Uint8List imageFile,
  }) async {
    try {
      UserCredential userCredential = await firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);

      String photoURL = await StorageMethods()
          .uploadImageToStorage('profilePics', imageFile, false);

      models.User user = models.User(
        username: username,
        uid: userCredential.user!.uid,
        photoURL: photoURL,
        email: email,
        bio: '',
        followers: [],
        following: [],
      );

      await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .set(user.toJson());

      result = 'success';
    } on FirebaseAuthException catch (error) {
      if (error.code == 'weak-password') {
        result = 'Error: Password length should more than 5 characters';
      } else if (error.code == 'email-already-in-use') {
        result = 'Error: The account already exists for that email.';
      }
    } catch (error) {
      result = error.toString();
    }

    return result;
  }

  Future<String> loginUser(String email, String password) async {
    try {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      result = 'success';
    } catch (error) {
      result = error.toString();
    }
    return result;
  }

  Future<models.User> getUserDetails() async {
    DocumentSnapshot user = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();

    return models.User.toUserModel(user);
  }
}
