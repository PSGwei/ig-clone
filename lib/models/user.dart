import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  const User({
    required this.username,
    required this.uid,
    required this.photoURL,
    required this.email,
    required this.bio,
    required this.followers,
    required this.following,
  });

  final String username;
  final String uid;
  final String photoURL;
  final String email;
  final String bio;
  final List followers;
  final List following;

  Map<String, dynamic> toJson() => {
        'username': username,
        'uid': uid,
        'email': email,
        'photoUrl': photoURL,
        'bio': bio,
        'followers': followers,
        'following': following,
      };

  static User toUserModel(DocumentSnapshot snapshot) => User(
        username: snapshot.get('username').toString(),
        uid: snapshot.get('uid').toString(),
        photoURL: snapshot.get('photoUrl').toString(),
        email: snapshot.get('email').toString(),
        bio: snapshot.get('bio').toString(),
        followers: snapshot.get('followers'),
        following: snapshot.get('following'),
      );
}
