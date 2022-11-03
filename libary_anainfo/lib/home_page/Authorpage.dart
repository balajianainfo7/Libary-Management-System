import 'dart:convert';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:libary_anainfo/Categories/detailedPage.dart';
import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';

import 'package:readmore/readmore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'components/food_part.dart';

class AuthorPage extends StatefulWidget {
    AuthorPage({Key? key});
  
  State<AuthorPage> createState() => AuthorPageState();
}
  class AuthorPageState extends State<AuthorPage> {

          
  
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
                          TextSpan(text: "Authors Details", style: TextStyle(color: Colors.grey))
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
                          tag: '',
                          child: Image(image: AssetImage('images/Thomas H. Cormen.jpg'),
                            
                            fit: BoxFit.cover,
                            width: 150,
                            height: 220,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20,),
                    Text("Thomas H. Cormen", style: TextStyle(fontSize: 25, color: Colors.black, fontWeight: FontWeight.bold),),
          
                  SizedBox(height: 20,),
            
                  Column(
                    
                    children: <Widget> [
                      // Max Size
                      Container(
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.0),
                          
                          color: Colors.white,
    
                        ),
                        // alignment: const Alignment (1,1),
                        
    
                        child: Column(
                        children:   [
                          
                         Padding(
                          padding: EdgeInsets.only(top: 25),
                          child: FutureBuilder<List<Food1>>(
             future: fetchFood(),
            builder: (context, snapshot){
              if(snapshot.hasData){
                var foodList = snapshot.data;
            return Column(
              children: [
                FoodPart(partName: "Published Books"),
                SingleChildScrollView(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(20),
                    primary: false,
                    shrinkWrap: true,
                    physics: const BouncingScrollPhysics(),
                    itemCount: foodList!.length,
                   
                    itemBuilder: (context, index) {
                      var food = foodList[index];
                      return GestureDetector(
                        onTap: () {
                          // Navigator.push(context, MaterialPageRoute(builder: (context) => DetailPage(id: food.id,)));
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
                          ),
    
                           
              
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
    
    
    
  }

 
}
