// import 'dart:convert';

// import 'package:flutter/material.dart';
// // import 'package:food_order_ui/configuration/food.dart';
// import 'package:http/http.dart' as http;
// import 'package:flutter_dotenv/flutter_dotenv.dart';
// import 'package:libary_anainfo/home_page/Food1.dart';
// import 'package:libary_anainfo/home_page/components/size_config.dart';
// import 'package:libary_anainfo/sample_home.dart';

// // import '../../../configuration/Food1.dart';

// class AuthorApi extends StatefulWidget {
//   // final String id;
//   const AuthorApi({Key? key}) : super(key: key);
  

//   @override
//   _AuthorApiState createState() => _AuthorApiState();
// }

// class _AuthorApiState extends State<AuthorApi> {
  


//   Future<List<Food1>> fetchFood() async {
//     final url = 'http://192.168.1.77:4000/product/getone?Category=Vegtables';
//     print(url);

//     final response = await http.get(Uri.parse(url), headers: <String, String>{
//       'authorization':
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhIjoiYmFsYWppQGdtYWlsLmNvbSIsImlhdCI6MTY2NTY1OTc4MCwiZXhwIjoxNjk3MTk1NzgwfQ.5RUbin6vdYpkCJUMz3aKhJuDEkNNZC0khMvkeSjnOIg'
//     });

//     final body = json.decode(response.body);
//     print(body);
//     return body.map<Food1>((data) => Food1.fromJson(data)).toList();
//     return body;
//   }

//     String foo = dotenv.get('HOST');
//     String id = "";
//   @override
//   Widget build(BuildContext context) {
//     return  FutureBuilder<List<Food1>>(
//       future: fetchFood(),
//       builder: (context, snapshot){
//         if(snapshot.hasData){
//           var foodList = snapshot.data;
//           return SizedBox(
//             height: SizeConfig.screenHeight!/3.40,               /// 265.0
//             child: ListView.builder(
//               scrollDirection: Axis.horizontal,
//               itemCount: foodList!.length,
//               itemBuilder: (context, index){
//                 var food = foodList[index];
//                 return Column(

//                   children: [
                    
//                     GestureDetector(
//                       onTap: (){
//                         // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailsScreen()));
//                       },
//                       child: Container(
//                         margin: EdgeInsets.only(
//                             left: 22           /// 4.0
//                         ),
//                         height: SizeConfig.screenHeight!/3.73,             /// 250.0
//                         width: SizeConfig.screenWidth!/2.055,              /// 200.0
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(20),
//                           boxShadow: [
//                             BoxShadow(
//                               offset: Offset(4, 6),
//                               blurRadius: 4,
//                               color: Colors.black.withOpacity(0.3),
//                             )
//                           ]
//                         ),
//                         child: Stack(
//                           fit: StackFit.expand,
//                           children: [
//                             Container(
//                               decoration: BoxDecoration(
//                                 image: DecorationImage(
//                                   image: NetworkImage("${foo}${food.path}"),
//                                   fit: BoxFit.cover,
//                                 ),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             Container(
//                               decoration: BoxDecoration(
//                                 color: Colors.black.withOpacity(0.4),
//                                 borderRadius: BorderRadius.circular(20),
//                               ),
//                             ),
//                             Positioned(
//                                 left: SizeConfig.screenWidth!/34.25,            /// 12.0
//                                 bottom: SizeConfig.screenHeight!/45.54,         /// 15.0
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text("${food.product_name}", style: TextStyle(fontSize: SizeConfig.screenHeight!/34.15, color: Colors.white)),       /// 20
//                                     Text("${food.product_description}", style: TextStyle(fontSize: SizeConfig.screenHeight!/48.79, color: Colors.white)),   /// 14
//                                     Text("\$${food.product_price}", style: TextStyle(fontSize: SizeConfig.screenHeight!/37.95, color: Colors.white))     /// 18
//                                   ],
//                                 )
//                             ),
//                             // Positioned(
//                             //   top: SizeConfig.screenHeight!/68.3,              /// 10.0
//                             //   right: SizeConfig.screenWidth!/41.1,             /// 10.0
//                             //   child: Icon(Icons.favorite, color: Colors.white))
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 );
//               },
//             ),
//           );
//         }
//         else{
//           return Center();
//         }
//       },
//     );
//   }
// }
