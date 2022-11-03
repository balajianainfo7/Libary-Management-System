import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/search.dart';

import 'dart:convert';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List<Food1> _posts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello World'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(
                builder: (ctx)=> SearchPage(posts: _posts,)
              ));
            },
          )
        ],
      ),

      body: FutureBuilder(
        future: _getData(),
        builder: (ctx,snapshot){
          if(snapshot.connectionState ==  ConnectionState.waiting)
            return CircularProgressIndicator();
//
          return ListView.builder(
            itemBuilder: (ctx,i){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ListTile(
                    title: Text(_posts[i].title),
                    subtitle: Text(_posts[i].author),
                  ),
                  Divider(height: 0,)
                ],
              );
            },
            itemCount: _posts.length,
          );
        },
      ),
    );
  }

  Future<void> _getData() async{
    var url = 'https://library-anainfo.herokuapp.com/users/getbycategory?Category=Civil';
    http.get(Uri.parse(url)).then((Body){
     return json.decode(Body.body);
    }).then((data){
      for(var json in data){
        _posts.add(Food1.fromJson(json));
      }
    }).catchError((e){
      print(e);
    });
  }
}