import 'dart:convert';
import 'dart:io';
import 'package:flutter_circular_text/circular_text.dart';

// import 'package:anatech/Auth/Login.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl_phone_field/phone_number.dart';
import 'package:libary_anainfo/profile/profile.dart';
import 'package:mime/mime.dart';
import 'package:progress_dialog_null_safe/progress_dialog_null_safe.dart';
import 'package:shared_preferences/shared_preferences.dart';
String token = "";
class Register extends StatefulWidget {
   static const id = 'Register';
//  String phoneNumber;
//  UserInfoEdit({@required this.phoneNumber});
// Go back to previous page
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

   @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadCounter();
    // _logout();
  }
   _loadCounter() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    setState(() {
      token = (preferences.getString('token') ?? '');
      
      // phoneNumber = (preferences.getString('phoneNumber') ?? '');
    });
  }
  bool _secureText = true;
  
  
  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  late ProgressDialog pr;

 
  XFile? imgUrl;

 
  String img =
      'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png';

  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //============================================= loading dialoge
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

    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.orange])),
      // image: DecorationImage(
      //   image: AssetImage('images/burger.jpg'),
      //   opacity: 0.5,
      //   fit: BoxFit.cover,
      // ),

      constraints: BoxConstraints.expand(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios, color: Colors.white,),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          title: Text('Register with Account', style: TextStyle(color: Colors.white),),
        ),
        body: SafeArea(
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.only(
                right: 10,
                left: 10,
                top: 10,
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    //======================================================================================== Circle Avatar
                    Container(
                      margin: EdgeInsets.only(top: 20),
                      alignment: Alignment.center,
                      child: Column(
                        children: <Widget>[
//                          CircularText(
//   children: [
//     TextItem(
//       text: Text(
//         "Chuck Norris".toUpperCase(),
//         style: TextStyle(
//           fontSize: 28,
//           color: Colors.blue,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       space: 12,
//       startAngle: -90,
//       startAngleAlignment: StartAngleAlignment.center,
//       direction: CircularTextDirection.clockwise,
//     ),
//     TextItem(
//       text: Text(
//         "top 100 Facts".toUpperCase(),
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.amberAccent,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       space: 10,
//       startAngle: 90,
//       startAngleAlignment: StartAngleAlignment.center,
//       direction: CircularTextDirection.anticlockwise,
//     ),
//   ],
//   radius: 125,
//   position: CircularTextPosition.inside,
//   backgroundPaint: Paint()..color = Colors.grey.shade200,
// ),
                          Stack(
                            children: <Widget>[
                              CircleAvatar(
                                // backgroundColor: Colors.blue,
                                // child: Text("ddd"),
                                backgroundImage: imgUrl == null
                                    ? 
                                    
                                    Image.network(
                                            'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                        .image
                                      :FileImage(File(imgUrl!.path.toString())) as FileImage,

//                                     :                        
//
//  CircularText(
//   children: [
//     TextItem(
//       text: Text(
//         "Chuck Norris".toUpperCase(),
//         style: TextStyle(
//           fontSize: 28,
//           color: Colors.blue,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       space: 12,
//       startAngle: -90,
//       startAngleAlignment: StartAngleAlignment.center,
//       direction: CircularTextDirection.clockwise,
//     ),
//     TextItem(
//       text: Text(
//         "top 100 Facts".toUpperCase(),
//         style: TextStyle(
//           fontSize: 20,
//           color: Colors.amberAccent,
//           fontWeight: FontWeight.bold,
//         ),
//       ),
//       space: 10,
//       startAngle: 90,
//       startAngleAlignment: StartAngleAlignment.center,
//       direction: CircularTextDirection.anticlockwise,
//     ),
//   ],
//   radius: 125,
//   position: CircularTextPosition.inside,
//   backgroundPaint: Paint()..color = Colors.grey.shade200,
// ) as FileImage,
                                    
                                    
                                // backgroundImage: _image == null
                                //     ? NetworkImage(
                                //         'https://git.unilim.fr/assets/no_group_avatar-4a9d347a20d783caee8aaed4a37a65930cb8db965f61f3b72a2e954a0eaeb8ba.png')
                                //     : FileImage(_image),
                                radius: 50.0,
                                // foregroundColor: Colors.black,
                              ),
                              InkWell(
                                onTap: _onAlertPress,
                                child: Container(
                                    padding: EdgeInsets.all(5),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(40.0),
                                        color: Colors.black),
                                    margin: EdgeInsets.only(left: 70, top: 70),
                                    child: Icon(
                                      Icons.photo_camera,
                                      size: 25,
                                      color: Colors.white,
                                    )),
                                
                              ),
                              
                            ],
                          ),
                          Text('Add Photos',
                              style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
    //=========================================================================================== Form
    //========================================== username
                   
    
                        Padding(
                          padding: EdgeInsets.all(14.0),
                        ),
                            Center(
                              child: SizedBox(
                                                      height: 44.0,
                                                      child: ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0)),
                                    primary: Colors.transparent,
                                    ),
                                
                                child: Text(
                                  "Update",
                                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                                ),
                                
                                
                                onPressed: () {
                                  // check();
                                  // if (_formKey.currentState!.validate()) {
                                          _startUploading();
                                          print("_startUploading");
                                          print(_startUploading);
                                        }
                                ),
                                                    ),
                            ),
                             
                                
                               
                              
                                ],
                              ),
                            
                          
                      ),
    //============================================================================================================= Form Finished
                    ),
                  
                ),
              ),
            ),
          );
  }

  //========================================================================== Funcions Area

  //========================= Gellary / Camera AlerBox
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
                      'images/login.png',
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
                      'images/login.png',
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
      imgUrl = _image;
      // Navigator.pop(context);
    });
  }

  //============================== Image from gallery
  Future getGalleryImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final XFile? _image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    setState(() {
      imgUrl = _image;
      // Navigator.pop(context);
    });
  }

  //============================================================= API Area to upload image
  Uri apiUrl = Uri.parse('http://192.168.1.77:4000/users/profile-change');

  Future<Map<String, dynamic>?> _uploadImage(XFile imgUrl) async {
    setState(() {
      pr.show();
    });
    print(apiUrl);

    final mimeTypeData =
        lookupMimeType(imgUrl.path, headerBytes: [0xFF, 0xD8])!.split('/');

    // Intilize the multipart request
    final imageUploadRequest = http.MultipartRequest('POST', apiUrl);

    // Attach the file in the request
    final file = await http.MultipartFile.fromPath('imgUrl', imgUrl.path);
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
        '$token';

    
    imageUploadRequest.fields['imgUrl'] = imgUrl.toString();

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
      if(response == 200){
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setString('picture', responseData['data']);
          print(preferences.getString('picture'));
        print("object");
      }else{
        print("object1");
        setState(() {
          Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ProfilePage1()),
        );
        });
      }
      _resetState();
      return responseData;
    } catch (e) {
      print(e);
      return null;
    }
  }

  void _startUploading() async {
    print("object1");
    if (imgUrl != XFile) {
      final Map<String, dynamic>? response = await _uploadImage(imgUrl!);

      // Check if any error occured
      if (response == null) {
        print("object");
        // pr.hide();
        messageAllert('User details updated successfully', 'Success');
      }
    } else {
      print("object");
      messageAllert('Please Select a profile photo', 'Profile Photo');
    }
  }

  void _resetState() {
    setState(() {
      pr.hide();
      // imgUrl;
      
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
                    MaterialPageRoute(builder: (context) => ProfilePage1()),
                  );
                },
              ),
            ],
          );
        });
  }
}
