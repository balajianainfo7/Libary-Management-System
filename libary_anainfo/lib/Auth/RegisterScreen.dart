import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:libary_anainfo/Auth/LoginScreen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyRegister extends StatefulWidget {
  const MyRegister({Key? key}) : super(key: key);

  @override
  _MyRegisterState createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegister> {
  late String username, RollNo, Idcard, phoneNo, password, year, address, gender, email, password2, deparment;
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
      Uri.parse("http://192.168.1.77:4000/users/sregister"),
      headers: <String, String>{
        'Content-type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        "username":username,
        "RollNo": RollNo,
        "Idcard": Idcard,
        "phoneNo":phoneNo,
        "password":password,
        "year":year,
        "address":address,
        "gender":gender,
        "email":email,
        "password2":password2,
        "deparment":deparment
      }),
    );

    print(response.body);
    final data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      // SharedPreferences preferences = await SharedPreferences.getInstance();
      // preferences.setString('email', email);
      // // preferences.setString('phoneNumber', phoneNumber);
      // print("object");
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
          MaterialPageRoute(builder: (context) => MyLogin()),
        );
      });
      loginToast("Register Sucessfull");
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => MyLogin()),
        );
      });
    } else if (response.statusCode == 400) {
      loginToast("Email or password is not correct");
    } else {
      loginToast("Register Failed");
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor:
            toast == "Register Sucessfull" ? Colors.green : Colors.red,
            
        textColor: Colors.white);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('images/register.png'), fit: BoxFit.cover),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          // appBar: AppBar(
          //   backgroundColor: Colors.transparent,
          //   elevation: 0,
          // ),
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Container(),
                Container(
                  padding: EdgeInsets.only(left: 35, top: 50),
                  child: Text(
                    'Libary Management\n\nCreate Account',
                    style: TextStyle(color: Colors.white, fontSize: 33),
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height * 0.28),
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
                                  return "Please Insert Name";
                                }
                              },
                              onSaved: (e) => username = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Name",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert Email";
                                }
                              },
                              onSaved: (e) => email = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Email",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.email, color: Colors.black),
                                  ),
                                      ),
                                ),
                                SizedBox(
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (e) {
                                if (e!.isEmpty) {
                                  return "Please Insert RollNo";
                                }
                              },
                              onSaved: (e) => RollNo = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "RollNo",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert Gender";
                                }
                              },
                              onSaved: (e) => gender = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Gender",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert Idcard";
                                }
                              },
                              onSaved: (e) => Idcard = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Idcard",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert Password";
                                }
                              },
                              onSaved: (e) => password = e!,
                                  style: TextStyle(color: Colors.black),
                                  obscureText: _secureText,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Password",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.person, color: Colors.black),
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
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (e) {
                                if (e!.isEmpty) {
                                  return "Please Insert Conform Password";
                                }
                              },
                              onSaved: (e) => password2 = e!,
                                  style: TextStyle(color: Colors.black),
                                  obscureText: _secureText,
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Confrom Password",
                                      hintStyle: TextStyle(color: Colors.black),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      prefixIcon: Padding(
                                    padding: EdgeInsets.only(left: 20, right: 15),
                                    child: Icon(Icons.person, color: Colors.black),
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
                                  height: 30,
                                ),
                                TextFormField(
                                  validator: (e) {
                                if (e!.isEmpty) {
                                  return "Please Insert phoneNo";
                                }
                              },
                              onSaved: (e) => phoneNo = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "phoneNo",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert Depertment";
                                }
                              },
                              onSaved: (e) => deparment = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "Depertment",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert year";
                                }
                              },
                              onSaved: (e) => year = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "year",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                  return "Please Insert address";
                                }
                              },
                              onSaved: (e) => address = e!,
                                  style: TextStyle(color: Colors.black),
                                  decoration: InputDecoration(
                                      enabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.white,
                                        ),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(10),
                                        borderSide: BorderSide(
                                          color: Colors.black,
                                        ),
                                      ),
                                      hintText: "address",
                                      hintStyle: TextStyle(color: Colors.black),
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
                                
                                // SizedBox(
                                //   height: 30,
                                // ),
                                
                                SizedBox(
                                  height: 40,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Sign Up',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 27,
                                          fontWeight: FontWeight.w700),
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
              MaterialPageRoute(builder: (context) => MyLogin()),
            );
                                        // Navigator.pushNamed(context, 'login');
                                      },
                                      child: Text(
                                        'Sign In',
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                            decoration: TextDecoration.underline,
                                            color: Colors.white,
                                            fontSize: 18),
                                      ),
                                      style: ButtonStyle(),
                                    ),
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
      ),
    );
  }
}