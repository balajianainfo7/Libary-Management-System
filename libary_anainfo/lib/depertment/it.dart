import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libary_anainfo/depertment/mechanical.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
import 'package:libary_anainfo/home_page/TrendingBooks.dart';

import 'package:libary_anainfo/home_page/components/food_part.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';

import 'package:libary_anainfo/home_page/widgets/recommed.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';
import 'package:libary_anainfo/home_page/widgets/username_text.dart';
// import 'components/size_config.dart';

class MechView extends StatefulWidget {
  const MechView({Key? key}) : super(key: key);

  @override
  _MechViewState createState() => _MechViewState();
}

class _MechViewState extends State<MechView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body:  SingleChildScrollView(
          child: Column(
                  children: <Widget> [
              
            
            
                    Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        IconButton(
                icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
                
                onPressed: () {
                    Navigator.pop(context);
                },
              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 40),
                          child: Text("Mechanical Engineering", style: TextStyle(fontSize: 20, color: Colors.black87),),
                        ),
                      ],
                    ),
                  ),
            
            
            
              
                    Column(
                        
                        children: <Widget> [
                          // Max Size
                          Container(
                            height: MediaQuery.of(context).size.height,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30.0),
                              
                              color: Colors.white54.withOpacity(0.8),
                        
                            ),
                            // alignment: const Alignment (1,1),
                            
                        
                            child: SingleChildScrollView(
                              child: Column(
                              children:   [
                               Padding(
                                padding: EdgeInsets.only(top: 25),
                                child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 25,
                                        top: 2,
                                        // bottom: 20,
                                        right:  5
                                           /// 10.0
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text("For You", style: TextStyle(fontSize: SizeConfig.screenHeight!/41.18, color: Colors.grey, fontWeight: FontWeight.bold),),  /// 20.0
                                      
                                
                                           /// 32.0
                                      ],
                                    ),
                                  ),
                                  
                                  
                                  ),
                                    
                                Mechanical(),
                                     ],
                                  ),
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
