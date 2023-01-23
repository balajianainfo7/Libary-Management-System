import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';

import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:shared_preferences/shared_preferences.dart';
String token = '';
class DetailPage extends StatefulWidget {
    DetailPage({Key? key, required this.id});
  String id;
  State<DetailPage> createState() => DetailPageState();
}
  class DetailPageState extends State<DetailPage> {

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


      void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Borrowed'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('You borrow a book from Libary.'),
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
          title: new Text('Out of Stock'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('Out of Stock books from Libary'),
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

  void _showcontent2() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Limit is over'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('You can\'t issue more than 3 books at a time'),
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


     Future<Map<String, dynamic>> fetchDetail() async {
    final url = 'http://192.168.1.77:4000/users/getoneBook/${widget.id}';
    // print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      "authorization":
          "$token",
    });

    final body = json.decode(response.body)['data'];
    print(body);
    print("body");
    
    return body ;
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
  
    // @override
    // void initState(){
    //   setState(() {
    //     requestRide(id);
    //   });
    //   super.initState();
    // }

  String foo = dotenv.get('HOST');
  
  @override
  Widget build(BuildContext context) {
    // @override
    // void initState(){
    //   setState(() {
        
    //     requestRide(id);
        
    //   });
    //   super.initState();
    // }
    return FutureBuilder(
            future: fetchDetail(),
            builder: (context, snapshot) {
              final users = snapshot.data.toString();

              // final user = users;

              print(users);
              // print(snapshot);

              if (snapshot.connectionState == ConnectionState.done) {
                // print(snapshot.data);
              }
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return Center(child: CircularProgressIndicator());
                default:
                  if (snapshot.hasError) {
                    return Center(child: Text('Some error occurred!'));
                  } else {
                    print("snapshot.data");
                    print(snapshot.data);
                    return _buildProductCard(snapshot.data);
                  }
              }
            });
  }

  Widget _buildProductCard(product){
    

    print('${foo}${product["image"]}');
    SizeConfig().init(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueAccent,
        body: SingleChildScrollView(
    
          child: Column(
                children: <Widget> [
            
    
    
           
              // DiscountCard(),
              // FoodPart(partName: "Categories"),
              // CategoriesFood(),
           
                      Padding(
                        padding: const EdgeInsets.all(8.0),
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
                         padding: const EdgeInsets.only(left: 15.0),
                         child: RichText(text: TextSpan(style: Theme.of(context).textTheme.titleLarge,
                    children: [
                          TextSpan(text: "Book Details ", style: TextStyle(color: Colors.grey))
                    ],
                    ),),
                     ),
                    ],
                    
                  ),
                      ),
                  
                
                
           

              
                        Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.shade600.withOpacity(0.3),
                            spreadRadius: 5,
                            blurRadius: 7,
                            offset: const Offset(0, 0),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Hero(
                          tag: product,
                          child: Image(image: NetworkImage('${foo}${product["image"]}'),
                            
                            fit: BoxFit.cover,
                            width: 150,
                            height: 220,
                          ),
                        ),
                      ),
                    ),
              
          
                  SizedBox(height: 20,),
            
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
                        
    
                        child: Column(
                        children:   [
                         Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    
                    
                    Text(
                      product["title"].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      product["author"].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.normal,
                          fontSize: 16,
                          color: Colors.grey),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.star,
                          color: Colors.amberAccent,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          "2.7" + '(85)',
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        // Text("a"?product[""]:null)
                        
                        const Icon(
                          Icons.visibility,
                          color: Colors.grey,
                          size: 18,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          numberFormat(124)+
                              "k Read",
                          style: const TextStyle(
                            fontWeight: FontWeight.normal,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     const Icon(
                    //       Icons.star,
                    //       color: Colors.amberAccent,
                    //       size: 18,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //       books.score.toString() + '(${books.review})',
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.normal,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //     const SizedBox(
                    //       width: 15,
                    //     ),
                    //     const Icon(
                    //       Icons.visibility,
                    //       color: Colors.grey,
                    //       size: 18,
                    //     ),
                    //     const SizedBox(
                    //       width: 5,
                    //     ),
                    //     Text(
                    //       numberFormat(int.parse(books.view.toString())) +
                    //           " Read",
                    //       style: const TextStyle(
                    //         fontWeight: FontWeight.normal,
                    //         fontSize: 15,
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    const SizedBox(
                      height: 5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        
                      ],
                    ),
                    const SizedBox(height: 12),
                    ReadMoreText(
                      product["description"].toString(),
                      trimLines: 1,
                      textAlign: TextAlign.justify,
                      colorClickableText: Colors.pink,
                      trimMode: TrimMode.Line,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                      style: const TextStyle(color: Colors.grey),
                      moreStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      lessStyle: TextStyle(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildEvelatedButton(
                            Icons.add, "BORROW", Color(0xFF29B6F6),
                            () {
                              // requestRide(product["_id"]);
                              requestRide(product["_id"]);
                          print("BORROW");
                        }),
                        const SizedBox(
                          width: 15,
                        ),
                        // _buildEvelatedButton(Icons.menu_book, "Read Now",
                        //     const Color(0xFF6741FF), () {
                        //   Navigator.of(context).push(MaterialPageRoute(
                        //       builder: (context) => ReadPage(
                        //             books: books,
                        //             settingsController: settingsController,
                        //           )));
                        // }),
                      ],
                    )
                  ],
                ),
              ),
            ),),
    
                           
              
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
    
    
    // Scaffold(
    //   backgroundColor: ThemeData.dark().canvasColor,
    //   body: SingleChildScrollView(
    //     child: Stack(
    //       children: [
    //         ShaderMask(
    //           shaderCallback: (rect) {
    //             return const LinearGradient(
    //               begin: Alignment.topCenter,
    //               end: Alignment.bottomCenter,
    //               colors: [Colors.black, Colors.transparent],
    //             ).createShader(Rect.fromLTRB(0, 0, rect.width, rect.height));
    //           },
    //           blendMode: BlendMode.dstIn,
    //           child: Image.asset(
    //             'images/detail_bg.png',
    //             height: 300,
    //             width: double.infinity,
    //             fit: BoxFit.cover,
    //           ),
    //         ),
    //         Padding(
    //           padding: EdgeInsets.fromLTRB(
    //               10, MediaQuery.of(context).padding.top, 10, 0),
    //           child: Row(
    //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //             children: [
    //               CircleAvatar(
    //                 radius: 22,
    //                 backgroundColor: Colors.grey[900],
    //                 child: IconButton(
    //                   onPressed: () {
    //                     Navigator.of(context).pop();
    //                   },
    //                   color: Colors.white,
    //                   icon: const Icon(
    //                     Icons.arrow_back_ios_new,
    //                   ),
    //                   iconSize: 20,
    //                 ),
    //               ),
    //             ],
    //           ),
    //         ),
    //         SizedBox(
    //           child: Padding(
    //             padding: const EdgeInsets.all(20),
    //             child: Column(
    //               mainAxisSize: MainAxisSize.min,
    //               crossAxisAlignment: CrossAxisAlignment.center,
    //               children: [
    //                 const SizedBox(
    //                   height: 150,
    //                 ),
    //                 Container(
    //                   decoration: BoxDecoration(
    //                     boxShadow: [
    //                       BoxShadow(
    //                         color: Colors.grey.shade600.withOpacity(0.3),
    //                         spreadRadius: 5,
    //                         blurRadius: 7,
    //                         offset: const Offset(0, 0),
    //                       ),
    //                     ],
    //                   ),
    //                   child: ClipRRect(
    //                     borderRadius: BorderRadius.circular(10),
    //                     child: Hero(
    //                       tag: product,
    //                       child: Image(image: NetworkImage('${foo}${product["path"]}'),
                            
    //                         fit: BoxFit.cover,
    //                         width: 150,
    //                         height: 220,
    //                       ),
    //                     ),
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 12,
    //                 ),
    //                 Text(
    //                   product["product_name"],
    //                   style: const TextStyle(
    //                     fontWeight: FontWeight.bold,
    //                     fontSize: 22,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 Text(
    //                   product["product_name"],
    //                   style: const TextStyle(
    //                       fontWeight: FontWeight.normal,
    //                       fontSize: 16,
    //                       color: Colors.grey),
    //                 ),
    //                 const SizedBox(
    //                   height: 15,
    //                 ),
    //                 // Row(
    //                 //   mainAxisAlignment: MainAxisAlignment.center,
    //                 //   children: [
    //                 //     const Icon(
    //                 //       Icons.star,
    //                 //       color: Colors.amberAccent,
    //                 //       size: 18,
    //                 //     ),
    //                 //     const SizedBox(
    //                 //       width: 5,
    //                 //     ),
    //                 //     Text(
    //                 //       books.score.toString() + '(${books.review})',
    //                 //       style: const TextStyle(
    //                 //         fontWeight: FontWeight.normal,
    //                 //         fontSize: 15,
    //                 //       ),
    //                 //     ),
    //                 //     const SizedBox(
    //                 //       width: 15,
    //                 //     ),
    //                 //     const Icon(
    //                 //       Icons.visibility,
    //                 //       color: Colors.grey,
    //                 //       size: 18,
    //                 //     ),
    //                 //     const SizedBox(
    //                 //       width: 5,
    //                 //     ),
    //                 //     Text(
    //                 //       numberFormat(int.parse(books.view.toString())) +
    //                 //           " Read",
    //                 //       style: const TextStyle(
    //                 //         fontWeight: FontWeight.normal,
    //                 //         fontSize: 15,
    //                 //       ),
    //                 //     ),
    //                 //   ],
    //                 // ),
    //                 const SizedBox(
    //                   height: 5,
    //                 ),
    //                 // Row(
    //                 //   mainAxisAlignment: MainAxisAlignment.center,
    //                 //   children: books.type!
    //                 //       .map((e) => Padding(
    //                 //             padding:
    //                 //                 const EdgeInsets.symmetric(horizontal: 5),
    //                 //             child: Chip(
    //                 //               label: Text(e),
    //                 //               backgroundColor:
    //                 //                   Theme.of(context).colorScheme.secondary,
    //                 //             ),
    //                 //           ))
    //                 //       .toList(),
    //                 // ),
    //                 const SizedBox(height: 12),
    //                 ReadMoreText(
    //                   "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
    //                   trimLines: 5,
    //                   textAlign: TextAlign.justify,
    //                   colorClickableText: Colors.pink,
    //                   trimMode: TrimMode.Line,
    //                   trimCollapsedText: 'Show more',
    //                   trimExpandedText: 'Show less',
    //                   style: const TextStyle(color: Colors.grey),
    //                   moreStyle: TextStyle(
    //                     color: Theme.of(context).colorScheme.primary,
    //                   ),
    //                   lessStyle: TextStyle(
    //                     color: Theme.of(context).colorScheme.primary,
    //                   ),
    //                 ),
    //                 const SizedBox(
    //                   height: 20,
    //                 ),
    //                 Row(
    //                   mainAxisAlignment: MainAxisAlignment.center,
    //                   children: [
    //                     _buildEvelatedButton(
    //                         Icons.add, "BORROW", Colors.grey.shade800,
    //                         () {
    //                       print("BORROW");
    //                     }),
    //                     const SizedBox(
    //                       width: 15,
    //                     ),
    //                     // _buildEvelatedButton(Icons.menu_book, "Read Now",
    //                     //     const Color(0xFF6741FF), () {
    //                     //   Navigator.of(context).push(MaterialPageRoute(
    //                     //       builder: (context) => ReadPage(
    //                     //             books: books,
    //                     //             settingsController: settingsController,
    //                     //           )));
    //                     // }),
    //                   ],
    //                 )
    //               ],
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    // );
  }

  Widget _buildEvelatedButton(
          IconData icon, String text, Color color, Function action) =>
      SizedBox(
        height: 40,
        width: 150,
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
              elevation: 0,
              primary: color,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          onPressed: () => action(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: Colors.white,
                size: 20,
              ),
              const SizedBox(
                width: 5,
              ),
              Text(
                text,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
      );
}

String numberFormat(int n) {
  String num = n.toString();
  int len = num.length;

  if (n >= 1000 && n < 1000000) {
    return num.substring(0, len - 3) +
        '.' +
        num.substring(len - 3, 1 + (len - 3)) +
        'k';
  } else if (n >= 1000000 && n < 1000000000) {
    return num.substring(0, len - 6) +
        '.' +
        num.substring(len - 6, 1 + (len - 6)) +
        'm';
  } else if (n > 1000000000) {
    return num.substring(0, len - 9) +
        '.' +
        num.substring(len - 9, 1 + (len - 9)) +
        'b';
  } else {
    return num.toString();
  }
}
