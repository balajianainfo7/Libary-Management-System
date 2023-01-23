
import 'package:flutter/material.dart';
import 'package:libary_anainfo/Auth/HistoryBooks.dart';
import 'package:libary_anainfo/Auth/historyView.dart';
import 'package:libary_anainfo/aaa/presentation/screens/home_page.dart';
import 'package:libary_anainfo/chat/chat_login.dart';
import 'package:libary_anainfo/home_page/home_page_view.dart';
import 'package:libary_anainfo/home_page/search1.dart';
import 'package:libary_anainfo/new/Mech.dart';
import 'package:libary_anainfo/new/geners.dart';
import 'package:libary_anainfo/profile/profile.dart';
import 'package:libary_anainfo/profile/searchDelagte.dart';

import '../aaa/sample.dart';

class BottomNav extends StatefulWidget {
  @override
  _BottomNavState createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedPosition = 0;
  List<Widget> listBottomWidget = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    addHomePage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
          BottomNavigationBarItem(
              icon: Icon(Icons.book_online), label: "Geners"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
        currentIndex: selectedPosition,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.grey.shade100,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        onTap: (position) {
          setState(() {
            selectedPosition = position;
          });
        },
      ),
      body: Builder(builder: (context) {
        return listBottomWidget[selectedPosition];
      }),
    );
  }

  void addHomePage() {
    listBottomWidget.add(SamplePageView());
    listBottomWidget.add(HistoryView());
    listBottomWidget.add(Geners());
    listBottomWidget.add(ProfilePage1());
  }
}
