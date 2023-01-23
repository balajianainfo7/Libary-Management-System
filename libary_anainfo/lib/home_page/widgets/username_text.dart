import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/home_page/components/colors.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
String username = "";
String picture = "";
String token = '';
class UserNameText extends StatefulWidget {
  const UserNameText({Key? key}) : super(key: key);

  @override
  _UserNameTextState createState() => _UserNameTextState();
}

class _UserNameTextState extends State<UserNameText> {

  
  Future<Map<String, dynamic>> fetchDetail() async {
    final url = 'http://192.168.1.77:4000/users/profile-picture';
    // print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      "authorization":
          "$token",
    });

    final body = json.decode(response.body);
    print(body);
    print("body");
    
    return body ;
    return body;
    
  }

  String foo = dotenv.get('HOST');
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = (preferences.getString('username') ?? '');
      //  picture = (preferences.getString('picture') ?? '');
       token = (preferences.getString('token') ?? '');
    });
    // var token = await preferences.getString('token') as String;
    print(username);
    // if (token == null) {
    //   Navigator.of(context).pushAndRemoveUntil(
    //       MaterialPageRoute(builder: (context) => new Login()),
    //       ((route) => false));
    // }
    // phoneNumber = (preferences.getString('phoneNumber') ?? '');
    
  }
  @override
  Widget build(BuildContext context) {
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
    print('${foo}${product["data"]}');
    return Padding(
      padding: EdgeInsets.fromLTRB(
          SizeConfig.screenWidth!/14.17,                 /// 29.0
          SizeConfig.screenHeight!/23.55,                /// 29.0
          SizeConfig.screenWidth!/11.74,                 /// 35.0
          SizeConfig.screenHeight!/68.3                  /// 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                          radius: 20.0,
                          backgroundImage: NetworkImage(
                              '${foo}${product["data"]}'),
                  ),
                  SizedBox(width: 10,),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight!/90.38 ,bottom: SizeConfig.screenHeight!/118.84),
                              /// 8.0 - 6.0
                    child: RichText(text: TextSpan(style: Theme.of(context).textTheme.titleMedium,
                    children: [
                      TextSpan(text: "Hi $username")
                    ],
                    ),
                      
                        /// 23
                  ),
                  ),
                  
                ],
              ),
              SizedBox(height: 15,),
              RichText(text: TextSpan(style: Theme.of(context).textTheme.headlineSmall,
                    children: [
                      TextSpan(text: "What are you reading today?"),
                      
                    ],
                    ),
                      
                        /// 23
                  ),
              // Text("", style: TextStyle(fontSize: SizeConfig.screenHeight!/45.18, color: Colors.black),)   /// 17
            ],
          ),
          
        ],
      ),
    );
  }
}
