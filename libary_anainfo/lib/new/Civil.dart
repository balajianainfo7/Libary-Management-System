import 'package:flutter/material.dart';
import 'package:libary_anainfo/Auth/HistoryBooks.dart';
import 'package:libary_anainfo/depertment/civil.dart';
import 'package:libary_anainfo/depertment/civil1.dart';
import 'package:libary_anainfo/depertment/civil2.dart';
import 'package:libary_anainfo/depertment/mechanical.dart';
import 'package:libary_anainfo/depertment/mechanical1.dart';
import 'package:libary_anainfo/depertment/mechanical2.dart';

// import 'material_design_indicator.dart';

class Civilview extends StatefulWidget {
  const Civilview({Key? key}) : super(key: key);

  @override
  _CivilviewState createState() => _CivilviewState();
}

class _CivilviewState extends State<Civilview>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);
  final _tabs = [
    Tab(text: 'Tab1'),
    Tab(text: 'Tab2'),
    Tab(text: 'Tab3'),
  ];

  final _iconTabs = [
    Tab(icon: Icon(Icons.home)),
    Tab(icon: Icon(Icons.search)),
    Tab(icon: Icon(Icons.settings)),
  ];

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
  length: 3,
  child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      bottom: TabBar(
        tabs: [
          Tab(text: "All",),
          Tab(text: "Construction",),
          Tab(text: "Survey",),
        ],
      ),
      title: Text('CIVIL ENGINEERING'),
    ),
    body: TabBarView(
      children: [
        civil(),
        civil1(),
        civil2(),
      ],
    ),
  ),
);

    
  }
}