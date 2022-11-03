import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/TrendingBooks.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/home_page/components/food_part.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';

import 'package:libary_anainfo/home_page/widgets/recommed.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';
import 'package:libary_anainfo/home_page/widgets/username_text.dart';


class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  String catageries = "getbycategory?Category=Mechanical";
     Future<List<Food1>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/${catageries}';
    print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNGY5MzI5NmJhZGE4NjU3ZGU4MzM1MSIsImlhdCI6MTY2NjE1OTQyMywiZXhwIjoxNjk3Njk1NDIzfQ.vZUQlJhgwikT7XUqvGSCTb1pYEN2b-DFT-MOFfFff10'
    });

    final body = json.decode(response.body);
    print(body);
    return body.map<Food1>((data) => Food1.fromJson(data)).toList();
    return body;
  }

    String foo = dotenv.get('HOST');
    String id = "";
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
    
          child: Column(
                children: <Widget> [
            
                  Row(
                    children: [
                      ElevatedButton(onPressed: (){
                        setState(() {
                          catageries = "getbycategory?Category=Mechanical";
                          future:
                          fetchFood();
                        });
                      }, child: Text("All")),
                      ElevatedButton(onPressed: (){
                        setState(() {
                          catageries = "getbycategory?Category=Mechanical";
                          future:
                          fetchFood();
                        });
                      }, child: Text("DOM"))
                    ],
                  ),
    
           
              // DiscountCard(),
              // FoodPart(partName: "Categories"),
              // CategoriesFood(),
           
               Padding(
                padding: EdgeInsets.only(bottom: 20, top: 20, right: 110),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CircleAvatar(
                        radius: 22,
                        backgroundColor: Colors.transparent,
                        child: IconButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          color: Colors.white,
                          icon: const Icon(
                            Icons.arrow_back_ios_new,
                          ),
                          iconSize: 20,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Text("Mechanical Engineering", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: "PT Sans"),),
                      )
                    ],
                    
                  ),
                  
                ),
                
              ),

              
          
    
            
                  Column(
                    
                    children: <Widget> [
                      // Max Size
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          color: Colors.white,
    
                        ),
                        // alignment: const Alignment (1,1),
                        
    
                        child: Column(
                        children:   [
                         Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: TrendingMovies()),
    
                           
              
                               ],
                            ),
                          ),
    
    
    
                      
    
    
    
                 ]
                      ),
    
                     ],
                  ),
          
          
          
              
             
            
        ),
      ),
    );
  }
}
