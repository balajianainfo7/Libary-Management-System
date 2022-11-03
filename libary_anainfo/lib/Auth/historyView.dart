import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:libary_anainfo/Auth/HistoryBooks.dart';
import 'package:libary_anainfo/Auth/bookShelf.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';

import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HistoryView extends StatefulWidget {
    HistoryView({Key? key});
  // String id;
  State<HistoryView> createState() => HistoryViewState();
}
  class HistoryViewState extends State<HistoryView> {

          
  @override
  Widget build(BuildContext context) {
    // @override
    // void initState(){
    //   setState(() {
        
    //     requestRide(id);
        
    //   });
    //   super.initState();
    // }
    
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
                        padding: const EdgeInsets.only(top: 20, left: 100, bottom: 40),
                        child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                        // CircleAvatar(
                        //   radius: 22,
                        //   backgroundColor: Colors.transparent,
                        //   child: IconButton(
                        //     onPressed: () {
                        //       Navigator.of(context).pop();
                        //     },
                        //     color: Colors.white,
                        //     icon: const Icon(
                        //       Icons.arrow_back_ios_new,
                        //     ),
                        //     iconSize: 20,
                        //   ),
                        // ),
                     Padding(
                         padding: const EdgeInsets.only(left: 15.0),
                         child: RichText(text: TextSpan(style: Theme.of(context).textTheme.titleLarge,
                    children: [
                          TextSpan(text: "BookShelf History ", style: TextStyle(color: Colors.white))
                    ],
                    ),),
                     ),
                    ],
                    
                  ),
                      ),
                  
                
                
           


                  Column(
                    
                    children: <Widget> [
                      // Max Size
                      SingleChildScrollView(
                        child: Container(
                          height: 5000,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30.0),
                            
                            color: Colors.white54.withOpacity(0.8),
                          
                          ),
                          // alignment: const Alignment (1,1),
                          
                          
                          child: Column(
                          children:   [
                           Padding(
                            padding: EdgeInsets.only(top: 25),
                            child: BookShelf(),
                            ),
                          
                             
                                    
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

 
}
