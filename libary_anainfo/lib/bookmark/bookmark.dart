// // import 'dart:html';

// import 'dart:convert';

// import 'package:flutter/material.dart';
// import 'package:libary_anainfo/bookmark/bookmark_model.dart';
// import 'package:libary_anainfo/bookmark/bookmarks_page.dart';
// import 'package:libary_anainfo/home_page/Food1.dart';
// import 'package:provider/provider.dart';
// import 'package:http/http.dart' as http;


// class BookmarkPage1 extends StatefulWidget {
//   @override
//   _BookmarkPage1State createState() => _BookmarkPage1State();
// }

// class _BookmarkPage1State extends State<BookmarkPage1> {
//  Future<List<Food1>> fetchFood() async {
//     final url = 'http://192.168.1.77:4000/users/getbycategory?Category=Mechanical&getbysubcategory=Themodynamics';
//     print(url);

//     final response = await http.get(Uri.parse(url), headers: <String, String>{
//       'authorization':
//           'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1NDg5NCwiZXhwIjoxNjk4NDkwODk0fQ.2e8ckaYZSVgH9LAuPCPmIdkBeKjO65jc6ooBqFnapeU'
//     });

//     final body = json.decode(response.body);
//     print(body);
//     return body.map<Food1>((data) => Food1.fromJson(data)).toList();
//     return body;
//   }

//   @override
//   Widget build(BuildContext context) {
//     var bookmarkBloc = Provider.of<BookmarkBloc>(context);

//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Bookmark Flutter"),
//         actions: [
//           Row(
//             children: [
//               Text(bookmarkBloc.count.toString()),
//               IconButton(
//                 icon: Icon(Icons.star),
//                 onPressed: () {
//                   Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) => BookmarksPage(),
//                       ));
//                 },
//               ),
//             ],
//           )
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             FutureBuilder<List<Food1>>(
//              future: fetchFood(),
//             builder: (context, snapshot){
//               if(snapshot.hasData){
//                 var foodList = snapshot.data;
//             return ListView.builder(
//               shrinkWrap: true,
//               physics: NeverScrollableScrollPhysics(),
//               itemCount: fetchFood().length,
//               itemBuilder: (context, index) {
//                 return ListTile(
//                   onTap: () {
//                     bookmarkBloc.addCount();
//                     // print(bookmarkBloc.count);

//                     Food1 itemModel = new Food1(
//                       title: fetchFood()[index]['title'],
//                       author: itemsList[index]['subtitle'],
//                     );

//                     bookmarkBloc.addItems(itemModel);

//                     print(bookmarkBloc.items[index].title);
//                     print(bookmarkBloc.items.length);

//                     setState(() {
//                       foodList[index] = "true";
//                     });
//                   },
//                   title: Text(itemsList[index]['title']),
//                   subtitle: Text(itemsList[index]['subtitle']),
//                   trailing: itemsList[index]['status'] == "false"
//                       ? Icon(Icons.star_border)
//                       : Icon(
//                           Icons.star,
//                           color: Colors.blue,
//                         ),
//                 );
//               },

//             );
//               }else{
//                 Center();
//               }
//             },
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }