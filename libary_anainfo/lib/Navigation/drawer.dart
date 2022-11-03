// import 'package:firebase_auth/firebase_auth.dart';

import 'dart:convert';
// import 'dart:html';

import 'package:http/http.dart' as http;
import 'package:dot_navigation_bar/dot_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:libary_anainfo/Auth/LoginScreen.dart';
import 'package:libary_anainfo/Navigation/bottomNav.dart';
import 'package:libary_anainfo/depertment/civil.dart';
import 'package:libary_anainfo/depertment/it.dart';
import 'package:libary_anainfo/depertment/mechanical.dart';
import 'package:libary_anainfo/home_page/TrendingBooks.dart';
import 'package:libary_anainfo/new/Civil.dart';
import 'package:libary_anainfo/new/Mech.dart';
import 'package:libary_anainfo/profile/CustomTextStyle.dart';
import 'package:libary_anainfo/sample_home.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';

import 'package:shared_preferences/shared_preferences.dart';
// import 'package:food_app_anainfo/login_screen.dart';

String username = '';
String username1 = '';
String idcard = '';
bool flag = true&&false;

// String phoneNumber = '';

class drawer extends StatefulWidget {
  @override
  _drawerState createState() => _drawerState(title: '');
}

class _drawerState extends State<drawer> {
  final String title;

  // Future<Widget> getStringValuesSF() async {
  //   final username = preferences.getString('email');
  //   SharedPreferences preferences = await SharedPreferences.getInstance();

  //   return Future.value(Text('${username}'));
  // }

  // final FirebaseAuth _auth = FirebaseAuth.instance;

  _drawerState({Key? key, required this.title});

  @override
  void initState() {
    super.initState();
    _loadCounter();
  }

 _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      username = (preferences.getString('username') ?? '');
      idcard = (preferences.getString('idcard') ?? '');
      flag = (preferences.getBool('flag') ?? true&&false)  as bool;
      // username1 = (preferences.getString('username') ?? '');
      // username2 = (preferences.getString('phoneNumber') ?? '');
      print(username);
      print(idcard);
      print(flag);
      // phoneNumber = (preferences.getString('phoneNumber') ?? '');
    });
  }

   late ProgressDialog pr;

 
  XFile? image;

  
  String img =
      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png';

  final _formKey = GlobalKey<FormState>();

   void _onAlertPress() async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/one.png',
                      width: 50,
                    ),
                    Text('Gallery'),
                  ],
                ),
                onPressed: getGalleryImage,
              ),
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Image.asset(
                      'images/one.png',
                      width: 50,
                    ),
                    Text('Take Photo'),
                  ],
                ),
                onPressed: getCameraImage,
              ),
            ],
          );
        });
  }

  // ================================= Image from camera
  Future getCameraImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? _image =
        await imagePicker.pickImage(source: ImageSource.camera);

    setState(() {
      image = _image;
      Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? _image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      image = _image;
      Navigator.pop(context);
    });
  }

  //============================================================= API Area to upload image
  Uri apiUrl = Uri.parse('http://192.168.1.77:4000/users/profile-change');

  Future<Map<String, dynamic>?> _uploadImage(XFile image) async {
    setState(() {
      pr.show();
    });
    print(apiUrl);

    final mimeTypeData =
        lookupMimeType(image.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('imgUrl', image.path);
    print(file);
    // Explicitly pass the extension of the image with request body
    // Since image_picker has some bugs due which it mixes up
    // image extension with file name like this filenamejpge
    // Which creates some problem at the server side to manage
    // or verify the file extension

//    imageUploadRequest.fields['ext'] = mimeTypeData[1];

    imageUploadRequest.files.add(file);
    print(file);
    imageUploadRequest.headers['Content-type'] = 'application/json';
    imageUploadRequest.headers['Accept'] = 'application/json';
    imageUploadRequest.headers['authorization'] =
        'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1ODM3MiwiZXhwIjoxNjk4NDk0MzcyfQ.qbGr7KnL_dAGJYMKByp4T3rm86EpLThdn8bj_g7EkGg';

    
    imageUploadRequest.fields['imgUrl'] = image.toString();

    try {
      final streamedResponse = await imageUploadRequest.send();
      final response = await http.Response.fromStream(streamedResponse);
      if (response.statusCode != 200) {
        return null;
      }
      print(imageUploadRequest);
      print(streamedResponse);
      print(response.body);
      final Map<String, dynamic> responseData = json.decode(response.body);
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _startUploading() async {
    if (image != XFile ) {
      final Map<String, dynamic>? response = await _uploadImage(image!);

      // Check if any error occured
      if (response == null) {
        pr.hide();
        messageAllert('User details updated successfully', 'Success');
      }
    } else {
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  void _resetState() {
    setState(() {
      pr.hide();
     
    });
  }

  messageAllert(String msg, String ttl) {
    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return new CupertinoAlertDialog(
            title: Text(ttl),
            content: Text(msg),
            actions: [
              CupertinoDialogAction(
                isDefaultAction: true,
                child: Column(
                  children: <Widget>[
                    Text('Okay'),
                  ],
                ),
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => MyLogin()),
                  );
                },
              ),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {

     pr = new ProgressDialog(context, type: ProgressDialogType.normal);

    //Optional
    pr.style(
      message: 'Please wait...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      progressWidget: CircularProgressIndicator(),
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );

   
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.black,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                icon: Icon(
                  Icons.notifications,
                  size: 30,
                ),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     new MaterialPageRoute(
                  //         builder: (context) => new SettingPage()));
                },
              ),
              // IconButton(
              //   icon: Icon(
              //     Icons.shopping_cart,
              //     size: 30,
              //   ),
              //   onPressed: () {
              //     Navigator.push(
              //         context,
              //         new MaterialPageRoute(
              //             builder: (context) => new OrdersPage()));
              //   },
              // ),
            ],
          ),
      
          body: Container(
            child: BottomNav(),
          ),
      
      //
          drawer: Drawer(
            //backgroundColor: ,
            // backgroundColor: AssetImage(''),
            backgroundColor: Colors.black,
      
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                Container(
                  child: UserAccountsDrawerHeader(
                    
                    
                    
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      // image: DecorationImage(
                      //   image: AssetImage("images/login.png"),
                      //   opacity: 0.2,
                      //   fit: BoxFit.cover,
                      // ),
                      gradient:
                          LinearGradient(colors: [Colors.white70.withOpacity(0.2), Colors.white70.withOpacity(0.2)]),
                    ),
      
                   
                      // Text(
                      //                 "$idcard",
                      //                 style: CustomTextStyle.textFormFieldMedium
                      //                     .copyWith(
                      //                         color: Colors.white,
                      //                         fontSize: 14),
                      //               ),
                   
                    accountName: Text(
                                      "$username\n\n$idcard",
                                      style: CustomTextStyle.textFormFieldMedium
                                          .copyWith(
                                              color: Colors.white,
                                              fontSize: 14),
                                    ),
      
                    accountEmail: Padding(
                                      padding: const EdgeInsets.only(left: 0),
                                      child: Row(
                                        children: [
                                          Text(
                                        "Violation Flag:",
                                        style: CustomTextStyle.textFormFieldMedium
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 14),
                                      ),
                                      SizedBox(width: 20,),
                                        Container(
                                                                child: flag ? Icon(Icons.circle, color: Colors.red,) : Icon(Icons.circle, color: Colors.green,)
                                                                 ),
                                                                 ],
                                      ),
                                    ),
      
                    
                  ),
                ),
                
                ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Colors.red.shade400,
                  ),
                  title: Text('DashBoard', style: TextStyle(color: Colors.white),),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => new HomePage()));
                  },
                ),
                 ExpansionTile(
                  // backgroundColor: Colors.red.shade400,
                  // iconColor: Colors.red.shade400,
                          title: Text("Depertment", style: TextStyle(color: Colors.white)),
                          leading: Icon(Icons.person, color: Colors.red.shade400,), //add icon
                          childrenPadding: EdgeInsets.only(left:60), //children padding
                          children: [
                               ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of Mechanical Engineering', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => HomePageaa()));
                  },
                ),
      
                              ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of Civil Engineering', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => Civilview()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of Electical Engineering', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of Eletronics Engineering', style: TextStyle(color: Colors.white)),
                  onTap: () {
                     Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of CSE', style: TextStyle(color: Colors.white)),
                  onTap: () {
                   Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
      
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of IT', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
      
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of BME', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
      
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of MBA', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
      
                ListTile(
                  leading: Icon(
                    Icons.restore,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Depertment of MCA', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    Navigator.push(
                        context,
                        new MaterialPageRoute(
                            builder: (context) => TrendingMovies()));
                  },
                ),
                          ],
                 ),
      
                //   ExpansionTile(
                //           title: Text("Categories"),
                //           leading: Icon(Icons.person), //add icon
                //           childrenPadding: EdgeInsets.only(left:60), //children padding
                //           children: [
                            
                //                ExpansionTile(
                //           title: Text("Mechanical Engineering"),
                //           leading: Icon(Icons.person), //add icon
                //           childrenPadding: EdgeInsets.only(left:60), //children padding
                //           children: [
                            
                //               ListTile(
                //   leading: Icon(
                //     Icons.account_circle,
                //     color: Colors.red.shade400,
                //   ),
                //   title: Text('ThermoDynmaics Engineering'),
                //   onTap: () {
                //     // Update the state of the app
                //     // ...
                //     // Then close the drawer
                //     // Navigator.push(
                //     //     context,
                //     //     new MaterialPageRoute(
                //     //         builder: (context) => UserNetworkPage()));
                //   },
                // ),
      
                //                //more child menu
                //           ],
                //          ),
      
                //                //more child menu
                //           ],
                //          ),
                
                ListTile(
                  leading: Icon(
                    Icons.account_circle,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Chat with us', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => UserNetworkPage()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.local_play,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Book Shef', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => GetAllRequest()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.event,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Profile', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => new CreateBlog()));
                  },
                ),
                ListTile(
                  leading: Icon(
                    Icons.favorite,
                    color: Colors.red.shade400,
                  ),
                  title: Text('About us', style: TextStyle(color: Colors.white)),
                  onTap: () {
                    // Navigator.push(
                    //     context,
                    //     new MaterialPageRoute(
                    //         builder: (context) => GetAllBlog()));
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    // Navigator.pop(context);
                  },
                ),
                
                ListTile(
                  leading: Icon(
                    Icons.settings,
                    color: Colors.red.shade400,
                  ),
                  title: Text('Logout', style: TextStyle(color: Colors.white)),
                  onTap: () async {
                    SharedPreferences preferences =
                        await SharedPreferences.getInstance();
                    preferences.remove('token');
                    // if(logout == "id"){
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => MyLogin()),
                        ((route) => false));
                    // }
                    // Update the state of the app
                    // ...
                    // // Then close the drawer
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: Container(
                    height: 1.0,
                    width: 130.0,
                    color: Colors.black12,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

}