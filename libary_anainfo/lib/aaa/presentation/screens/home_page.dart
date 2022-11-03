import 'package:flutter/material.dart';
import 'package:libary_anainfo/aaa/presentation/components/loading_widget.dart';
import 'package:libary_anainfo/aaa/presentation/components/user_tile.dart';

import '../../data/data_model.dart';
import '../../domain/repository.dart';


class HomePageView1 extends StatefulWidget {
  @override
  _HomePageView1State createState() => _HomePageView1State();
}

class _HomePageView1State extends State<HomePageView1> {
  List<User> _users = <User>[];
  List<User> _usersDisplay = <User>[];

  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers().then((value) {
      setState(() {
        _isLoading = false;
        _users.addAll(value);
        _usersDisplay = _users;
        print(_usersDisplay.length + 1);
        
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Users List'),
        // ),
        body: SafeArea(
          child: Container(
            child: ListView.builder(
              itemBuilder: (context, index) {
                if (!_isLoading) {
                  print(this._usersDisplay);
                  return index == 0 ? _searchBar() : UserTile(user: this._usersDisplay[index - 1]);
                  
                  
                } else {
                  // print(_usersDisplay[2]);
                  return LoadingView();
                  
                }
                
              },
              itemCount: _usersDisplay.length + 1,

            ),
          ),
        ),
      ),
    );
  }

  _searchBar() {
    return Padding(
      padding: EdgeInsets.all(12.0),
      child: TextField(
        autofocus: false,
        onChanged: (searchText) {
          searchText = searchText.toLowerCase();
          setState(() {
            _usersDisplay = _users.where((u) {
              var fName = u.title.toLowerCase();
              var lName = u.author.toLowerCase();
              var job = u.Sname.toLowerCase();
              return fName.contains(searchText) || lName.contains(searchText) || job.contains(searchText);
            }).toList();
          });
        },
        // controller: _textController,
        decoration: InputDecoration(
          
          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(20.0)),),
          prefixIcon: Icon(Icons.search),
          hintText: 'Search Users',
        ),
      ),
    );
  }
}
