import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:libary_anainfo/Auth/LoginScreen.dart';
import 'package:libary_anainfo/Auth/Registerprofile.dart';
import 'package:libary_anainfo/profile/AboutUsPage.dart';
import 'package:libary_anainfo/profile/CustomTextStyle.dart';
import 'package:libary_anainfo/profile/EditProfilePage.dart';
import 'package:libary_anainfo/profile/list_profile_section.dart';
import 'package:libary_anainfo/profile/searchable.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'InviteFriendsPage.dart';
import 'NotificationPage.dart';

String username = '';
String id = '';
bool flag = true&&false;
// String username1 = '';
// String username2 = '';

class ProfilePage1 extends StatefulWidget {
  @override
  _ProfilePage1State createState() => _ProfilePage1State();
}

class _ProfilePage1State extends State<ProfilePage1> {

   Future<Map<String, dynamic>> fetchDetail() async {
    final url = 'http://192.168.1.77:4000/users/profile-picture';
    // print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      "authorization":
          "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNjBmOTIxYWE0MmI3MjdhNTI4N2I4MyIsImlhdCI6MTY2NzMwOTQxOCwiZXhwIjoxNjk4ODQ1NDE4fQ.NDK07VBfP_OCyAUmE1J7c2Tq1rmlQUTg0meWUks8CNs",
    });

    final body = json.decode(response.body);
    print(body);
    print("body");
    
    return body ;
    return body;
    
  }

  String foo = dotenv.get('HOST');
  List<ListProfileSection> listSection = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createListItem();
    _loadCounter();
    // _logout();
  }

  void createListItem() {
    listSection.add(createSection("Notifications", "images/notification.png",
        Colors.blue.shade800, widget));
    listSection.add(createSection(
        "Payment Method", "images/payment.png", Colors.teal.shade800, widget));
    listSection.add(createSection("Invite Friends", "images/invite.png",
        Colors.indigo.shade800, InviteFriendsPage()));
    listSection.add(createSection("About Us", "images/about.jpg",
        Colors.black.withOpacity(0.8), AboutPage()));
  }

  

  createSection(String title, String icon, Color color, Widget widget) {
    return ListProfileSection(title, icon, color, widget);
  }

 

  _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = (preferences.getString('username') ?? '');
      id = (preferences.getString('idcard') ?? '');
      flag = (preferences.getBool('flag') ?? true&&false)  as bool;
      // username1 = (preferences.getString('username') ?? '');
      // username2 = (preferences.getString('phoneNumber') ?? '');
      print(username);
      print(id);
      print(flag);
      // phoneNumber = (preferences.getString('phoneNumber') ?? '');
    });
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
    if (flag) {
    flag = true;
  } else {flag = false;}
    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      resizeToAvoidBottomInset: true,
      // appBar: AppBar(
      //   backgroundColor: Colors.black,
      //     leading: IconButton(
      //       icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
      //       onPressed: () {
      //         Navigator.pop(context);
      //       },
      //     ),
      //     title: Text('Account Profile', style: TextStyle(color: Colors.white),),
      // ),
      body: Builder(builder: (context) {
        return Container(
          child: Stack(
            children: <Widget>[
              Container(
                height: 240,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10))),
                // child: Stack(
                //   children: <Widget>[
                //     Positioned(
                //       child: Container(
                //         width: 200,
                //         height: 200,
                //         decoration: BoxDecoration(
                //             color: Colors.black, shape: BoxShape.circle),
                //       ),
                //       top: -40,
                //       left: -40,
                //     ),
                //     Positioned(
                //       child: Container(
                //         width: 300,
                //         height: 260,
                //         decoration: BoxDecoration(
                //             color: Colors.black.withOpacity(0.5),
                //             shape: BoxShape.circle),
                //       ),
                //       top: -40,
                //       left: -40,
                //     ),
                //     Positioned(
                //       child: Align(
                //         child: Container(
                //           width: 400,
                //           height: 260,
                //           decoration: BoxDecoration(
                //               color: Colors.black.withOpacity(0.5),
                //               shape: BoxShape.rectangle),
                //         ),
                //       ),
                //       top: -40,
                //       left: -40,
                //     ),
                //   ],
                // ),
              ),
              Container(
                child: Text(
                  "Profile",
                  style: CustomTextStyle.textFormFieldBold
                      .copyWith(color: Colors.white, fontSize: 24),
                ),
                margin: EdgeInsets.only(top: 72, left: 24),
              ),
              Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Container(),
                    flex: 20,
                  ),
                  Expanded(
                    child: Container(
                      child: Stack(
                        children: <Widget>[
                          Container(
                            child: Card(
                              margin:
                                  EdgeInsets.only(top: 50, left: 16, right: 16),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(16))),
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: 8, top: 8, right: 8, bottom: 8),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        IconButton(
                                          icon: Icon(Icons.settings),
                                          iconSize: 24,
                                          color: Colors.black,
                                          onPressed: () {},
                                        ),
                                        IconButton(
                                            icon: Icon(Icons.edit),
                                            color: Colors.black,
                                            iconSize: 24,
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  new MaterialPageRoute(
                                                      builder: (context) =>
                                                          Register()));
                                            },
                                          ),
                                        
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  
                                  Text(
                                    "$username",
                                    style: CustomTextStyle.textFormFieldMedium
                                        .copyWith(
                                            color: Colors.grey.shade700,
                                            fontSize: 14),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 50),
                                    child: Text(
                                      "$id",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 14),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 8,
                                  ),

                                  Padding(
                                    padding: const EdgeInsets.only(left: 125),
                                    child: Row(
                                      children: [
                                        Text(
                                      "Violation Flag:",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Colors.grey.shade700,
                                              fontSize: 14),
                                    ),
                                    SizedBox(width: 20,),
                                      Container(
                                                              child: flag ? Icon(Icons.circle, color: Colors.red,) : Icon(Icons.circle, color: Colors.green,)
                                                               ),
                                                               ],
                                    ),
                                  ),
                                  
                                  SizedBox(
                                    height: 16,
                                  ),


                                  Container(
                                    height: 2,
                                    width: double.infinity,
                                    color: Colors.grey.shade200,
                                  ),
                                  buildListView(),
                                  
                                ],
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.topCenter,
                            child: Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Colors.grey.shade400, width: 2),
                                  shape: BoxShape.circle,
                                  // prefixIcon:const Icon(Icons.safety_check),
                                  image: DecorationImage(
                                      image: NetworkImage('${foo}${product["data"]}'),
                                      fit: BoxFit.cover),
                                      
                                      ),
                                      
                              width: 100,
                              height: 100,
                            ),
                            
                          ),

                        ],
                        
                      ),
                      
                    ),
                    flex: 75,
                  ),
                  Expanded(
                    child: Container(),
                    flex: 05,
                  ),
                          

                ],
              )
            ],
          ),
        );
      }),
    );
    
  }

  ListView buildListView() {
    return ListView.builder(
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return createListViewItem(listSection[index]);
      },
      itemCount: listSection.length,
    );
  }

  createListViewItem(ListProfileSection listSection) {
    return Builder(builder: (context) {
      return InkWell(
        splashColor: Colors.teal.shade200,
        onTap: () {
          if (listSection.widget != null) {
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (context) => listSection.widget));
          }
        },
        child: Container(
          margin: EdgeInsets.only(left: 16, right: 12),
          padding: EdgeInsets.only(top: 12, bottom: 12),
          child: Row(
            children: <Widget>[
              Image(
                image: AssetImage(listSection.icon),
                width: 20,
                height: 20,
                color: Colors.grey.shade500,
              ),
              SizedBox(
                width: 12,
              ),
              Text(
                listSection.title,
                style: CustomTextStyle.textFormFieldBold
                    .copyWith(color: Colors.grey.shade500),
              ),
              Spacer(
                flex: 1,
              ),
              Icon(
                Icons.navigate_next,
                color: Colors.grey.shade500,
              )
            ],
          ),
        ),
      );
    });
  }
  _logout() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.remove('token');
    // if(logout == "id"){
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const MyLogin()),
        ((route) => false));
    // }
    // Update the state of the app
    // ...
    // // Then close the drawer
    
  }
  
}
