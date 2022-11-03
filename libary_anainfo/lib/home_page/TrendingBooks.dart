import 'dart:convert';

import 'package:flutter/material.dart';
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
import '../Categories/detailedPage.dart';

class TrendingMovies extends StatefulWidget {
  State<TrendingMovies> createState() => TrendingMoviesState();
}
  class TrendingMoviesState extends State<TrendingMovies> {
     String catageries = "getimageproduct";
     Future<List<Food1>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/getbycategory?Category=Mechanical';
    print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1NDg5NCwiZXhwIjoxNjk4NDkwODk0fQ.2e8ckaYZSVgH9LAuPCPmIdkBeKjO65jc6ooBqFnapeU'
    });

    final body = json.decode(response.body);
    print(body);
    return body.map<Food1>((data) => Food1.fromJson(data)).toList();
    return body;
  }

    String foo = dotenv.get('HOST');
    String id = "";


  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Food1>>(
       future: fetchFood(),
      builder: (context, snapshot){
        if(snapshot.hasData){
          var foodList = snapshot.data;
      return Column(
        children: [
          Container(
                height: 25,
                margin: EdgeInsets.only(bottom: 30),
                padding: EdgeInsets.only(right: 80),
                child: DefaultTabController(
                  length: 3,
                  child: TabBar(
                      labelPadding: EdgeInsets.all(0),
                      indicatorPadding: EdgeInsets.all(0),
                      isScrollable: true,
                      labelColor: kBlackColor,
                      unselectedLabelColor: kGreyColor,
                      labelStyle: GoogleFonts.openSans(
                          fontSize: 14, fontWeight: FontWeight.w700),
                      unselectedLabelStyle: GoogleFonts.openSans(
                          fontSize: 14, fontWeight: FontWeight.w600),
                      indicator: RoundedRectangleTabIndicator(
                          weight: 2, width: 20,  color: Colors.blueAccent),
                      tabs: [
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.transparent.withOpacity(1.0)),
                              child: Text("All"), onPressed: (){
                                 Navigator.push(context, MaterialPageRoute(builder: (context) => MemberBookshelfScreen()));
                              },),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.transparent.withOpacity(1.0)),
                              child: Text("All"), onPressed: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorPage()));
                              },),
                          ),
                        ),
                        Tab(
                          child: Container(
                            margin: EdgeInsets.only(right: 23),
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(primary: Colors.transparent.withOpacity(1.0)),
                              child: Text("All"), onPressed: (){
                                //  Navigator.push(context, MaterialPageRoute(builder: (context) => AuthorPage()));
                              },),
                          ),
                        ),
                        // TabBarView(children: [
                          
                        // ])
                      ]),

                ),
                
                
              ),
              // TabBarView(children: children),
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          //     children: [
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: ()=>{}, child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //       SizedBox(width: 20,),

                
          //       ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: (){
          //           setState(() {
                      
          //           });
          //         }, 
                  
          //         child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //       SizedBox(width: 20,),
          //        ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: ()=>{}, child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //       SizedBox(width: 20,),
          //        ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: ()=>{}, child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //       SizedBox(width: 20,),
          //        ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: ()=>{}, child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //       SizedBox(width: 20,),
          //        ElevatedButton(
          //         style: ElevatedButton.styleFrom(primary: Colors.transparent),
                  
          //         onPressed: ()=>{}, child: Column(
          //         children: [
          //           Icon(Icons.pedal_bike),
          //           Text("DOM")
          //         ],
          //       ),),
          //     ],
          //   ),
          // ),
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
                  height: 120,
                  child: Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Hero(
                          tag: foodList[index],
                          child: Image(image: NetworkImage("${foo}${food.image}"),
                            
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
                            Text(
                              "${food.author}",
                              style: const TextStyle(color: Colors.grey, fontFamily: "PT Sans"),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
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
      );
        }
         else{
          return Center();
        }
  },
    );
  }
}
