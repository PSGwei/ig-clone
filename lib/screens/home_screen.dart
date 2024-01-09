import 'package:flutter/material.dart';
import 'package:instagram_clone/utilities/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int page = 0;
  PageController pageController = PageController();

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  void navigationTapped(int page) {
    pageController.jumpToPage(page);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        children: [
          Text('1'),
          Text('2'),
          Text('3'),
          Text('4'),
          Text('5'),
        ],
        controller: pageController,
        onPageChanged: (value) {
          setState(() {
            page = value;
          });
        },
        physics:
            const NeverScrollableScrollPhysics(), //disable swipe left and right to change page
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: page == 0 ? primaryColor : secondaryColor,
            ),
            label: '',
            backgroundColor: mobileBackgroundColor,
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.search,
              color: page == 1 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.add_circle,
              color: page == 2 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.favorite,
              color: page == 3 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.person,
              color: page == 4 ? primaryColor : secondaryColor,
            ),
            label: '',
          ),
        ],
        onTap: navigationTapped,
      ),
    );
  }
}
