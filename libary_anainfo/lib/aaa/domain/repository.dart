import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:libary_anainfo/aaa/data/data_model.dart';


final String url = "http://192.168.1.77:4000/users/getAllbook";

List<User> parseUser(String responseBody){
  var list = json.decode(responseBody)['data'] as List<dynamic>;
  var users = list.map((e) => User.fromJson(e)).toList();
  return users;
}

Future<List<User>> fetchUsers() async{
  final http.Response response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1NDg5NCwiZXhwIjoxNjk4NDkwODk0fQ.2e8ckaYZSVgH9LAuPCPmIdkBeKjO65jc6ooBqFnapeU'
    });

  if (response.statusCode == 200) {
    return compute(parseUser,response.body);
  } else {
    throw Exception(response.statusCode);
  }
}
