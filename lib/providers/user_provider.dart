import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/utilities/methods/authentication.dart';

class UserProvider with ChangeNotifier {
  User? _user;

  User? get getUser => _user;

  Future<void> refreshUser() async {
    User user = await AuthMethods().getUserDetails();
    _user = user;
    notifyListeners();
  }
}
