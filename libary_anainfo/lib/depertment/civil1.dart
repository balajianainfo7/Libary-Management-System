import 'dart:convert';

import 'package:flutter/material.dart';
// import 'package:food_order_ui/configuration/food.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/Categories/detailedPage.dart';
import 'package:libary_anainfo/home_page/Authorpage.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';
import 'package:libary_anainfo/home_page/widgets/search_food.dart';
import 'package:libary_anainfo/new/consttants.dart';
import 'package:libary_anainfo/new/reading_card_list.dart';
import 'package:libary_anainfo/new/two_side_rounded_button.dart';
import 'package:libary_anainfo/sample_home.dart';
import 'package:libary_anainfo/home_page/widgets/color_constant.dart';
import 'package:libary_anainfo/home_page/widgets/custom_tab_indicator.dart';
import 'package:google_fonts/google_fonts.dart';


// import '../../../configuration/Food1.dart';

class civil1 extends StatefulWidget {
  // final String id;
  const civil1({Key? key}) : super(key: key);
  

  @override
  _civil1State createState() => _civil1State();
}

class _civil1State extends State<civil1> with TickerProviderStateMixin{
  String categories = "getbycategory?Category=Mechanical";


  Future<List<Food1>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/getbycategory?Category=Civil&getbysubcategory=Survey';
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
    TabController _tabController = TabController(length: 6, vsync: this);
    return   SingleChildScrollView(
      child: Column(
                children: [
    
        
                  FutureBuilder<List<Food1>>(
             future: fetchFood(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                var foodList = snapshot.data;
            return Column(
              children: [
                SearchFood(),
                SingleChildScrollView(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    primary: false,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: foodList!.length,
                   
                    itemBuilder: (context, index) {
                      var food = foodList[2];
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
                                      height: 5,
                                    ),
                                    Text(
                                      "${food.code}",
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
                ),
              ],
            );
              }
               else{
                return Center();
              }
          },
          ),
                ],
              
       
      ),
    );
  }
}
