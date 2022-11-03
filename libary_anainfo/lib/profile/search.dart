// import 'package:flutter/material.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'dart:async';
// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:get/get.dart';
// import 'package:shared_preferences/shared_preferences.dart';


// class Search extends StatefulWidget {
//   const Search({Key? key}) : super(key: key);

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   TextEditingController searchController = TextEditingController();
//   FocusNode myFocusNode = new FocusNode();
//     var list = [];
//     var Resultarr = [];
//   var filterListArr =[];


//   @override
//   void initState() {
//      searchlist();
//     super.initState();
//   }
//   @override
//   Widget build(BuildContext context) {
//     double _height = MediaQuery.of(context).size.height;
//     double _width = MediaQuery.of(context).size.width;



//     return Scaffold(
//       resizeToAvoidBottomInset: false,
//       appBar: AppBar(
//         backgroundColor: Colors.transparent,
//         elevation: 0.0,
//         toolbarHeight: 60,
//         title: Text(
//           'Search',
//           style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
//         ),
//         leading: const BackButton(color: Colors.black),
//       ),
//       body: SingleChildScrollView(
//         child: Container(
//           margin: EdgeInsets.all(15.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Container(
//                 width: _width / 1.02,
//                 child: Padding(
//                   padding: const EdgeInsets.symmetric(vertical: 10.0),
//                   child: TextFormField(
//                     onChanged:(value){
//                       searchlist();
//                     },
//                     focusNode: myFocusNode,
//                     controller: searchController,
//                     decoration: InputDecoration(
//                       enabledBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(width: 1, color: Colors.black12),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       focusedBorder: OutlineInputBorder(
//                         borderSide:
//                             const BorderSide(width: 1, color: Colors.black12),
//                         borderRadius: BorderRadius.circular(10),
//                       ),
//                       hintText: 'Search,book,novel,short stories',
//                       suffixIcon: IconButton(
//                         onPressed: () {},
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.black,
//                         ),
//                       ),
//                     ),
//                     validator: (value) {
//                       if (value!.isEmpty) {
//                         return 'Data';
//                       }
//                       return null;
//                     },
//                   ),
//                 ),
//               ),
//               Container(
//                 child: Text(
//                   'Search Your EarHook Stories',
//                   style: TextStyle(
//                       color: Colors.black,
//                       fontSize: 18.0,
//                       fontWeight: FontWeight.bold),
//                 ),
//               ),
//               SizedBox(height: 18.0),
//               Container(
//                 height: _height / 1.6,
//                 child: SingleChildScrollView(
//           child: 
//           searchs.isEmpty?Center(
//                 child: Text('No Stories found'),
//                ): 
//           Column(
//             children: <Widget>[
//               GridView.builder(
//                   physics: ScrollPhysics(),
//                   shrinkWrap: true,
//                   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                            mainAxisSpacing:0.5,
//                            childAspectRatio: .66,
//                            crossAxisCount: 2,
//                            crossAxisSpacing: 15
//                   ),
//                   itemCount: searchs.length,
//                   padding: EdgeInsets.all(10),
//                   itemBuilder: (BuildContext context, int index) {
//                     return GestureDetector(
//                       onTap: () async{
//                          var pref =
//                                             await SharedPreferences.getInstance();
//                                         var customerId =
//                                             pref.getString('customer_id');
//                                         if (customerId.toString() == "" ||
//                                             customerId == null) {
//                                           //changed from push to pushReplacement - JERRY
//                                           Navigator.pushReplacement(
//                                               context,
//                                               MaterialPageRoute(
//                                                   builder: (context) => Login()));
//                                         } else
//                                           Navigator.of(context).push(MaterialPageRoute(
//                                       builder: (context) => newreleases(
//                                             audiodetail: searchs[index]['story_id'],
      
//                                             // index: index
//                                           )
//                                           )
//                                           );
//                       },
//                       child: Card(
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
                            
//                             Center(
//                               child: Image.network(
//                                 searchs[index]['story_images'].toString(),
//                                 fit: BoxFit.fill,
                                
//                                 height: _height /4,
//                                       width: _width,
//                               ),
//                             ),
//                            SizedBox(
//                              height: 10,
//                            ),
//                             Center(
//                               child: Text(
//                                 searchs[index]['story_title'].toString(),
//                                 style: TextStyle(
//                                     fontSize: 13, fontWeight: FontWeight.bold),textAlign: TextAlign.center,
//                               ),
//                             ),
                           
//                             // Text(
//                             //   list[index]['author_name'].toString(),
//                             //   style: TextStyle(
//                             //       fontSize: 18, fontWeight: FontWeight.bold),
//                             // ),
                           
                           
//                           ],
//                         ),
//                       ),
//                     );
//                   }),
             
//             ],
//           ),
//         ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//  Future<void> searchlist() async {
//     var url = "https://api.earhook.in/UserApi/search";
     
//     // checker(context) async {
//     var pref = await SharedPreferences.getInstance();
//     var search = pref.getString('search');
//      var storyid = pref.getString('story_id');
   
//     var finalurl = Uri.parse(url);
//     var res = await http.post(finalurl, headers: <String, String>{
//       'X-API-KEY': 'd1c11b10599e380607c42297b8184eb2'
//     }, body: {
//       'search': searchController.text,
      
//     });
//     var decodeValue = json.decode(res.body);

//     setState(() {
//        searchs = decodeValue['data'];
//     });
    
//     print(res.body);
    

//   }

// }

