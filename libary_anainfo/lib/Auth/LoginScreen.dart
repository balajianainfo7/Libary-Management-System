import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:libary_anainfo/Auth/RegisterScreen.dart';
import 'package:libary_anainfo/Navigation/drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyLogin extends StatefulWidget {
  const MyLogin({Key? key}) : super(key: key);

  @override
  _MyLoginState createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLogin> {

    late String Idcard, password;
  final _key = new GlobalKey<FormState>();

  bool _secureText = true;
  bool? remember = false;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();

      login();

      // loginwithphone();

    }
  }

  login() async {
    print(Idcard);
    print(password);
    final response = await http.post(
      Uri.parse("http://192.168.1.21:4000/users/userLogin"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "Idcard": Idcard,
        "password": password,
      }),
    );

    print(response.body);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      SharedPreferences preferences = await SharedPreferences.getInstance();
      preferences.setString('Idcard', Idcard);
      preferences.setString('token', data['data']['token']);
      preferences.setString('username', data['data']['username']);
      preferences.setString('idcard', data['data']['Idcard']);
      print(preferences.getString('idcard'));
       preferences.setBool('flag', data['data']['violationFlag']);
       print(preferences.getBool('flag'));
          print(preferences.getString('username'));
      print("aaadddvcikjnkjnvcknj");
      print(preferences.getString('token'));
      preferences.setString('id', data['data']['id']);
      print(preferences.getString('id'));
      // preferences.setString('phoneNumber', phoneNumber);
      print("object");
      // print(preferences.getString('email'));
      // preferences.setString('token', data['data']['token']);
      // print(preferences.getString('token'));
      // print(preferences.getString('token'));
      // preferences.setString('id', data['data']['id']);
      // print(preferences.getString('id'));
      print(data);
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => drawer()),
        );
      });
      loginToast("Login Sucessfull");
    } else if (response.statusCode == 400) {
      loginToast("Email or password is not correct");
    } else {
      loginToast("Login Failed");
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor:
            toast == "Login Sucessfull" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('images/login.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              Container(),
              Container(
                padding: EdgeInsets.only(left: 35, top: 130),
                child: Text(
                  'Libary Management\n\nWelcome Back',
                  style: TextStyle(color: Colors.white, fontSize: 33),
                ),
              ),
              Container(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Form(
                         key: _key,
                        child: Container(
                          margin: EdgeInsets.only(left: 35, right: 35),
                          child: Column(
                            children: [
                              TextFormField(
                                 validator: (e) {
                              if (e!.isEmpty) {
                                return "Please Insert Idcard";
                              }
                            },
                            onSaved: (e) => Idcard = e!,
                                style: TextStyle(color: Colors.black),
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Idcard",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    prefixIcon: Padding(
                                  padding: EdgeInsets.only(left: 20, right: 15),
                                  child: Icon(Icons.person, color: Colors.black),
                                ),
                                    ),
                              ),
                              SizedBox(
                                height: 30,
                              ),
                              TextFormField(
                                validator: (e) {
                              if (e!.isEmpty) {
                                return "Password Can't be Empty";
                              }
                            },
                            obscureText: _secureText,
                            onSaved: (e) => password = e!,
                                style: TextStyle(),
                                
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade100,
                                    filled: true,
                                    hintText: "Password",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                     prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.black),
                              ),
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                                    ),
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Sign in',
                                    style: TextStyle(
                                        fontSize: 27, fontWeight: FontWeight.w700),
                                  ),
                                  CircleAvatar(
                                    radius: 30,
                                    backgroundColor: Color(0xff4c505b),
                                    child: IconButton(
                                        color: Colors.white,
                                        onPressed: () {
                                           check();
                                        },
                                        icon: Icon(
                                          Icons.arrow_forward,
                                        )),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 40,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => MyRegister()),
          );
                                      // Navigator.pushNamed(context, 'register');
                                    },
                                    child: Text(
                                      'Sign Up',
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18),
                                    ),
                                    style: ButtonStyle(),
                                  ),
                                  TextButton(
                                      onPressed: () {},
                                      child: Text(
                                        'Forgot Password',
                                        style: TextStyle(
                                          decoration: TextDecoration.underline,
                                          color: Color(0xff4c505b),
                                          fontSize: 18,
                                        ),
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              
            ],
          ),
        ),
      ),
    );
  }
}