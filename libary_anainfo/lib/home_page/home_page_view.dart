import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libary_anainfo/bookmark/bookmarks_page.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
import 'package:libary_anainfo/home_page/Authorpage1.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/TrendingBooks.dart';

import 'package:libary_anainfo/home_page/components/food_part.dart';
import 'package:libary_anainfo/home_page/search.dart';

import 'package:libary_anainfo/home_page/widgets/recommed.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';
import 'package:libary_anainfo/home_page/widgets/username_text.dart';
import 'package:libary_anainfo/new/consttants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Categories/detailedPage.dart';
import 'components/size_config.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

String username = "";
class HomePageView extends StatefulWidget {
  const HomePageView({Key? key}) : super(key: key);

  @override
  _HomePageViewState createState() => _HomePageViewState();
}

class _HomePageViewState extends State<HomePageView> {


    static var failureSnackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'On Snap!',
      message:
          'You have failed to read this failure message.\nPlease try again!',
      contentType: ContentType.failure,
    ),
  );

  /// help
  static var helpSnackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Out of Stock!',
      message:
          'Books are out of stock from libary.\nplease wait...',
      contentType: ContentType.help,
    ),
  );

  /// success
  static var successSnackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Success!',
      message:
          'You borrowed books from libary.\nPlease return or renwel within 6 days!',
      contentType: ContentType.success,
    ),
  );

  /// warning
  static var warningSnackBar = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Warning!',
      message: 'Your limit is three books only.\nPlease read carefully!',
      contentType: ContentType.warning,
    ),
  );

  static var violationFlag = SnackBar(
    elevation: 0,
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    content: AwesomeSnackbarContent(
      title: 'Warning!',
      message: 'You are flagged for violating rules/delay on returning books paying fines.\nUntill the flag is lifted, You can\'t issue any books!',
      contentType: ContentType.warning,
    ),
  );

   

  List<Food1> _posts = [];

  Future<List<Food1>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/getbycategory?Category=Civil';
    print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1ODM3MiwiZXhwIjoxNjk4NDk0MzcyfQ.qbGr7KnL_dAGJYMKByp4T3rm86EpLThdn8bj_g7EkGg'
    });

    final body = json.decode(response.body);
    if(response.statusCode == 200){
        print("balaji");
          }
    print(body);
    return body.map<Food1>((data) => Food1.fromJson(data)).toList();
    
    return body;
  }

  void requestRide(id) async {
      print("object");
                      final response = await http.post(
                        Uri.parse("http://192.168.1.77:4000/users/issuebooks"),
                        headers: <String, String>{
                          'Content-type': 'application/json; charset=UTF-8',
                          'authorization':
                              "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1ODM3MiwiZXhwIjoxNjk4NDk0MzcyfQ.qbGr7KnL_dAGJYMKByp4T3rm86EpLThdn8bj_g7EkGg",
                        },
                        body: jsonEncode(<String, String>{
                          "_id": id.toString(),
                        }),
                      );
                      print(response.body);
                      final data = jsonDecode(response.body);
                      if (response.statusCode == 200) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                    .showSnackBar(successSnackBar);
                        });
                      }else if(response.statusCode == 400){
                        ScaffoldMessenger.of(context)
                    .showSnackBar(helpSnackBar);
                      }else if(response.statusCode == 500){
                        ScaffoldMessenger.of(context)
                    .showSnackBar(warningSnackBar);
                      }else if(response.statusCode == 600){
                        ScaffoldMessenger.of(context)
                    .showSnackBar(violationFlag);
                      }
                      
                      else{
                        Text("Failed");
                      }
                      print(data);
                      
                    }

    String foo = dotenv.get('HOST');
    String id = "";
    
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.blueAccent,
      body: SingleChildScrollView(

        child: Column(
              children: <Widget> [
          


          UserNameText(),
            SearchFood(),
            // DiscountCard(),
            // FoodPart(partName: "Categories"),
            // CategoriesFood(),
            Padding(
      padding: EdgeInsets.only(
          left: 25,
          top: 20,
          bottom: 20,
          right:  5
             /// 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("Top Authors", style: TextStyle(fontSize: SizeConfig.screenHeight!/41.18, color: Colors.white, fontWeight: FontWeight.bold),),  /// 20.0
         ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),primary: Color(0xFF29B6F6),),
                                
                                child: Text(
                                  "See All",
                                  style: TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.w700),
                                ),
                                
                                
                                onPressed: () {
                                
                                }),
             /// 32.0
        ],
      ),
    ),

            Padding(
              padding: EdgeInsets.only(bottom: 25),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  
                           InkWell(
                      onTap: (){
                         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthorPage()),
        );
                       },
                      child: Column(
                        children: [
                          CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage(
                              'images/Thomas H. Cormen.jpg'),
                  ),
                  Text("Thomas H. Cormen", style: TextStyle(fontSize: 18, color: Colors.white),)
                        ],
                      ),
                  
                           ),
                           InkWell(
                      onTap: (){
                        
        //                  // do something here();
                         Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => AuthorPage1()),
        );
                       },
                      child: Column(
                        children: [
                          CircleAvatar(
                          radius: 30.0,
                          backgroundImage: AssetImage(
                              'images/Darren Ashby.jpg'),
                  ),
                  Text("Darren Ashby", style: TextStyle(fontSize: 18, color: Colors.white),)
                        ],
                      ),
                  
                           ),
                ],
              ),
            ),

        

          
                Column(
                  
                  children: <Widget> [
                    // Max Size
                    Container(
                      
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30.0),
                        
                        color: Colors.white54.withOpacity(0.8),

                      ),
                      // alignment: const Alignment (1,1),
                      

                      child: Column(
                      children:   [
                       Padding(
                        padding: EdgeInsets.only(top: 25),
                        child: Padding(
      padding: EdgeInsets.only(
          left: 25,
          // top: 2,
          // bottom: 2,
          right:  5
             /// 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text("For You", style: TextStyle(decoration: TextDecoration.overline,decorationStyle: TextDecorationStyle.dotted,fontSize: SizeConfig.screenHeight!/41.18, color: Colors.black, fontWeight: FontWeight.bold,),),  /// 20.0
         
             /// 32.0
        ],
      ),
    ),),
                        
                        FoodPart(partName: "All Books"),

                         Column(
                           children: [
          //                   IconButton(onPressed: (){
          //                     Navigator.pushReplacement(
          // context,
          // MaterialPageRoute(builder: (context) => SearchPage(posts: _posts)),);
          //                   }, icon: Icon(Icons.search)),
                             FutureBuilder<List<Food1>>(
      future: fetchFood(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          
          var foodList = snapshot.data;
          return SizedBox(
            height: SizeConfig.screenHeight!/3.40,               /// 265.0
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: foodList!.length,
              itemBuilder: (context, index){
                var food = foodList[index];
                return Column(
                  children: [
                        Container(
      margin: EdgeInsets.only(left: 24, ),
      height: 235,
      width: 202,
      child: Stack(
        children: <Widget>[
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              // height: 300,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.8),
                borderRadius: BorderRadius.circular(29),
                boxShadow: [
                  BoxShadow(
                    offset: Offset(0, 10),
                    blurRadius: 33,
                    color: kShadowColor,
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
             
                
                borderRadius: BorderRadius.circular(29),
                
              
            child: Image(image: NetworkImage("${foo}${food.image}")
              ,
              width: 200,
            ),
          ),
          Positioned(
            top: 10,
            right: 10,
            child: Column(
              children: <Widget>[
                
              IconButton(
                icon: Icon(foodList[index] == "false" ? Icons.star: Icons.star, color: Colors.blue,),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BookmarksPage(),
                      ));
                },

              ),
              ],
            ),
          ),
          Positioned(
            top: 160,
            
            child: Container(
              height: 77,
              width: 202,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(children: [
                  Padding(
                    padding: EdgeInsets.only(left: 24),
                    child: RichText(
                      maxLines: 2,
                      text: TextSpan(
                        style: TextStyle(color: kBlackColor),
                        children: [
                              TextSpan(
                                text: "${food.title}\n",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "${food.author}",
                                style: TextStyle(
                                  color: kLightBlackColor,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  // SizedBox(width: 70,),
                  
                  ],),
                  Spacer(),
                  Row(
                    children: <Widget>[
                      Expanded(
                        child: GestureDetector(
                          onTap: (){
                            Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return DetailPage(id: food.bookId.toString(),);
                                      },
                                    ),
                                  );
                                
                          },
                          child: Container(
                              alignment: Alignment.center,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(29),
                                  bottomLeft: Radius.circular(29),
                                ),
                              ),
                              child: Text(
                                "Details",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                        ),
                      ),
                      Expanded(
                        child: GestureDetector(
      onTap: (){
        // Navigator.push(
        //                           context,
        //                           MaterialPageRoute(
        //                             builder: (context) {
        //                               return AuthorPage();
        //                             },
        //                           ),
        //                         );

        requestRide(food.id);
      }  ,
      child: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(vertical: 10),
        decoration: BoxDecoration(
          color: Color(0xFF29B6F6),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(29),
            bottomRight: Radius.circular(29),
          ),
        ),
        child: Text(
          "Borrow",
          style: TextStyle(color: Colors.white),
        ),
      ),
    ),
                      
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    ),
                      // ReadingListCard(
                      //     image: ,
                      //     title: ,
                      //     auth: "",
                      //     rating: 4.9,
                      //     pressDetails: () {
                               
                      //     }, pressRead: (){
                      //       GestureDetector(onTap: (){
                      //         Navigator.push(
                      //         context,
                      //         MaterialPageRoute(
                      //           builder: (context) {
                      //             return AuthorPage();
                      //           },
                      //         ),
                      //       );
                      //       },);
                                 
                      //     },
                      //   ),
                    
                  ],
                );
              },
            ),
          );
        }
        else{
          return Center();
        }
      },
    ),
                           ],
                         ),
            FoodPart(partName: "Popular"),
            RecommedFoods(),
            FoodPart(partName: "Story"),
            RecommedFoods(),
            // TrendingMovies()
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
