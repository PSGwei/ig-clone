import 'package:flutter/material.dart';
import 'package:instagram_clone/models/user.dart';
import 'package:instagram_clone/providers/user_provider.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    getUser();
  }

  void getUser() async {
    //retrieve an instance of UserProvider from the nearest ancestor Provider in the widget tree
    // listen:false -> get the value one time
    UserProvider userProvider = Provider.of<UserProvider>(context);
    await userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).getUser;
    if (user != null) {
      return Center(
        child: Text(user.username),
      );
    } else {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }
  }
}
