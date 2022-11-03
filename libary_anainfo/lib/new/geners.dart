import 'package:flutter/material.dart';
import 'package:libary_anainfo/Auth/HistoryBooks.dart';
import 'package:libary_anainfo/depertment/mechanical.dart';
import 'package:libary_anainfo/depertment/mechanical1.dart';
import 'package:libary_anainfo/depertment/mechanical2.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';

// import 'material_design_indicator.dart';

class Geners extends StatefulWidget {
  const Geners({Key? key}) : super(key: key);

  @override
  _GenersState createState() => _GenersState();
}

class _GenersState extends State<Geners>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  final _selectedColor = Color(0xff1a73e8);
  final _unselectedColor = Color(0xff5f6368);

  @override
  void initState() {
    _tabController = TabController(length: 5, vsync: this);
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
  length: 5,
  child: Scaffold(
    appBar: AppBar(
      backgroundColor: Colors.black,
      bottom: TabBar(
        isScrollable: true,
        tabs: [
          Tab(text: "Thriller",),
          Tab(text: "Romance",),
          Tab(text: "Comedy",),
          Tab(text: "Action",),
          Tab(text: "Documentery",),
        ],
        
      ),
      
      title: Text('Geners'),
      
    ),
    
    body: TabBarView(
      children: [
        Mechanical(),
        Mechanical1(),
        Mechanical2(),
        Mechanical2(),
        Mechanical2(),
      ],
    ),
    
  ),
  
);

    
  }
}