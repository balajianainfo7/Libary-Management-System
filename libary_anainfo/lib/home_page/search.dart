import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/Food1.dart';


class SearchPage extends StatefulWidget {
  final List<Food1> posts;

  SearchPage({required this.posts});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<Food1> _searchedPost = [];


  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
          title: TextField(
            style: TextStyle(color: Colors.white),
            decoration: InputDecoration(
              hintText: 'Search Post',
              hintStyle: TextStyle(color: Colors.white),
              border: InputBorder.none
            ),
            onChanged: (val){
              setState(() {
                _searchedPost = widget.posts.where(
                    (el)=>el.title.contains(val)
                ).toList();
              });
            },
          ),
        ),
    
        body: _searchedPost.isEmpty ?
          Center(
            child: Text('No match',style: Theme.of(context).textTheme.headline3,),
          ):
        ListView.builder(
          itemCount: _searchedPost.length,
          itemBuilder: (context, index){
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                ListTile(
                  title: Text(_searchedPost[index].title),
                  subtitle: Text(_searchedPost[index].author),
                ),
                Divider(height: 0,)
              ],
            );
          },
        ),
      ),
    );
  }
}