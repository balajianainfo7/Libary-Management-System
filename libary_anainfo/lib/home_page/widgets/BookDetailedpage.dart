import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';

import 'package:libary_anainfo/home_page/components/food_part.dart';

import 'package:libary_anainfo/home_page/widgets/recommed.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';
import 'package:libary_anainfo/home_page/widgets/username_text.dart';
import '../components/size_config.dart';


class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(

        child: Column(
              children: <Widget> [
          
                Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: FoodPart(partName: "All Books")),
                    
        

          
                Column(
                  
                  children: <Widget> [
                    // Max Size 

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        color: Colors.white,

                      ),
                      // alignment: const Alignment (1,1),
                      alignment: const Alignment (1,1),
                      height: MediaQuery.of(context).size.height,
                      width: 500,

                      child: Column(
                      children:   [
                       Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Align(
          alignment: Alignment.topCenter,
          child: Container(
            height: 230,
            width: 155,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/login.png"),
                fit: BoxFit.fill,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
          ),
        ),),
                        
                        // FoodPart(partName: "All Books")),
                        
                              Text("Author Name"),

                              ElevatedButton(onPressed: ()=>{}, child: Text("BORROW"))
            //              RecommedFoods(),
            // FoodPart(partName: "Popular"),
            // RecommedFoods(),
            // FoodPart(partName: "Story"),
            // RecommedFoods(),
                             ],
                             
                          ),
                        ),


            
                    



               ]
                    ),

                   ],
                ),
        
        
        
            
           
          
      ),
    );
  }
}
