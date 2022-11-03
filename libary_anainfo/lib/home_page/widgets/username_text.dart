import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/components/colors.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';
import 'package:shared_preferences/shared_preferences.dart';
String username = "";
class UserNameText extends StatefulWidget {
  const UserNameText({Key? key}) : super(key: key);

  @override
  _UserNameTextState createState() => _UserNameTextState();
}

class _UserNameTextState extends State<UserNameText> {
  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

  _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = (preferences.getString('username') ?? '');
    });
    var token = await preferences.getString('token') as String;
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
                          backgroundImage: AssetImage(
                              'images/R.S. Khurmi.jpg'),
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
