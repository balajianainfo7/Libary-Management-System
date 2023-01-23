import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
// import 'package:food_order_ui/configuration/food.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/Categories/detailedPage.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';
import 'package:libary_anainfo/new/consttants.dart';
import 'package:libary_anainfo/new/reading_card_list.dart';
import 'package:libary_anainfo/new/two_side_rounded_button.dart';
import 'package:libary_anainfo/sample_home.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'BookDetailedpage.dart';

// import '../../../configuration/Food1.dart';
String token = "";
class RecommedFoods extends StatefulWidget {
  // final String id;
  const RecommedFoods({Key? key}) : super(key: key);
  

  @override
  _RecommedFoodsState createState() => _RecommedFoodsState();
}

class _RecommedFoodsState extends State<RecommedFoods> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
    // _logout();
  }
   _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      token = (preferences.getString('token') ?? '');
      
      // phoneNumber = (preferences.getString('phoneNumber') ?? '');
    });
  }

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
          '$token'
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
                              "$token",
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
    return  FutureBuilder<List<Food1>>(
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
                
               Icon(Icons.favorite_border, color: Colors.black87,)
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
    );
  }
}
