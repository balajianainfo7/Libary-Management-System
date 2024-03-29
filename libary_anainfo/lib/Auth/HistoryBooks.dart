import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:libary_anainfo/Auth/Books.dart';
import 'package:libary_anainfo/depertment/mba.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
// import 'package:ez_book/src/models/books.dart';
// import 'package:ez_book/src/pages/detail/detail.dart';
// import 'package:ez_book/src/pages/home/widget/category_title.dart';
import 'package:libary_anainfo/home_page/category_title.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:libary_anainfo/home_page/widgets/color_constant.dart';
import 'package:libary_anainfo/home_page/widgets/custom_tab_indicator.dart';
import 'package:libary_anainfo/new/Mech.dart';
import 'package:libary_anainfo/sample/member_bookshelf_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Categories/detailedPage.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
String token = "";
class HistroyBooks extends StatefulWidget {
  State<HistroyBooks> createState() => HistroyBooksState();
}
  class HistroyBooksState extends State<HistroyBooks> {

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
          'You borrowed books from libary.\nPlease continue working!',
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

     void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Renwed'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('Your Books has been renwed.'),
              ],
            ),
          ),
          actions: [
            new ElevatedButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showcontent1() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('No issues'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('You have time'),
              ],
            ),
          ),
          actions: [
            new ElevatedButton(
              child: new Text('Ok'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
    //  String catageries = "getimageproduct";
     Future<List<Books>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/getallAct';
    print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          '$token'
    });

    final body = json.decode(response.body)['data'];
    print(body);
    return body.map<Books>((data) => Books.fromJson(data)).toList();
    return body;
  }

  void Renwel(id) async {
      print("object");
                      final response = await http.post(
                        Uri.parse("http://192.168.1.77:4000/users/book-renew"),
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
                      print(id);
                      if (response.statusCode == 200) {
                        setState(() {
                          _showcontent();
                        });
                      }else if(response.statusCode == 400){
                        _showcontent1();
                      }else{
                       _showcontent1();
                      }
                      print(data);
                      
                    }


                    void Return(id) async {
      print("object");
                      final response = await http.post(
                        Uri.parse("http://192.168.1.77:4000/users/book-return"),
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
                      print(id);
                      final data = jsonDecode(response.body);
                      if (response.statusCode == 200) {
                        setState(() {
                          ScaffoldMessenger.of(context)
                    .showSnackBar(failureSnackBar);
                          // _showcontent();
                        });
                      }else if(response.statusCode == 400){
                        // _showcontent1();
                        ScaffoldMessenger.of(context)
                    .showSnackBar(failureSnackBar);
                      }else{
                        Text("Failed");
                      }
                      print(data);
                      
                    }

    String foo = dotenv.get('HOST');
    String id = "";


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Books>>(
       future: fetchFood(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          var foodList = snapshot.data;
      return SingleChildScrollView(
        child: Column(
          children: [
            
            ListView.builder(
              padding: const EdgeInsets.all(20),
              primary: false,
              shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: foodList!.length,
             
              itemBuilder: (context, index) {
                var food = foodList[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: food.id,)));
                  },
                  
                  child: SizedBox(
                    height: 180,
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Hero(
                            tag: foodList[index],
                            child: Image(image: AssetImage("images/login.png"),
                              
                              fit: BoxFit.cover,
                              height: 100,
                              width: 90,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "${food.title}",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16, fontFamily: "PT Sans"),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Text(
                              //   "${food.info}",
                              //   style: const TextStyle(color: Colors.grey, fontFamily: "PT Sans"),
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              // Row(
                              //   children: [
                              //                                   Text(
                              //   "Issues: ${food.issueDate}",
                              //   style: const TextStyle(color: Colors.black, fontFamily: "PT Sans"),
                              // ),
                              // Text(
                              //   " ---- ",
                              //   style: const TextStyle(color: Colors.grey, fontFamily: "PT Sans"),
                              // ),
                              //                               Text(
                              //   "${food.returnDate}",
                              //   style: const TextStyle(color: Colors.black, fontFamily: "PT Sans"),
                              // ),
                              //   ],
                              // ),
                              const SizedBox(
                                height: 5,
                              ),
                              Row(
                                children: [
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),primary: Color(0xFF29B6F6),),
                                    onPressed: (){
                                    Renwel(food.id);
                                  }, child: Row(
                                    children: [
                                      Icon(Icons.repeat_rounded, color: Colors.white,),
                                      Text(" Renwel",style: TextStyle(color: Colors.white),),
                                    ],
                                  )),
                                  const SizedBox(
                                width: 5,
                              ),
                                  ElevatedButton(
                                      style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),primary: Color(0xFF29B6F6)),
                                    
                                    onPressed: (){
                                    Return(id);
                                  }, child: Row(
                                    children: [
                                      Icon(Icons.reset_tv_rounded, color: Colors.white,),
                                      Text(" Return", style: TextStyle(color: Colors.white),),
                                    ],
                                  )),
                                ],
                              )
                              // Text(
                              //   moviesTrendingList[index].type!.join(", "),
                              //   maxLines: 1,
                              //   overflow: TextOverflow.ellipsis,
                              //   softWrap: true,
                              //   style: const TextStyle(
                              //       color: Colors.grey, fontSize: 14),
                              // )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
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
