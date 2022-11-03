import 'dart:convert';

import 'package:libary_anainfo/home_page/Food1.dart';
import 'package:http/http.dart' as http;
class Students {
  final String title;
  final String id;

  Students({required this.id, required this.title});
  factory Students.fromJson(Map<String, dynamic> json) => Students(
        id: json['_id'].toString(),
        title: json['title'].toString(),
        
      );
}
 Future<List<Students>> fetchFood() async {
    final url = 'http://192.168.1.77:4000/users/getbycategory?Category=Mechanical&getbysubcategory=Themodynamics';
    print(url);

    final response = await http.get(Uri.parse(url), headers: <String, String>{
      'authorization':
          'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJkYXRhMSI6IjYzNWJiNjdhNGVjZWE4OGY0YThmNTQ2NyIsImlhdCI6MTY2Njk1NDg5NCwiZXhwIjoxNjk4NDkwODk0fQ.2e8ckaYZSVgH9LAuPCPmIdkBeKjO65jc6ooBqFnapeU'
    });

    final body = json.decode(response.body);
    print(body);
    return body.map<Students>((data) => Students.fromJson(data)).toList();
    return body;
  }
// List<Students> studentDetails = [
//   Students(name: "Abish", id: 1),
//   Students(name: "Bob", id: 2),
//   Students(name: "Charlie", id: 3),
//   Students(name: "Dany", id: 4),
//   Students(name: "Esha", id: 5),
//   Students(name: "balaji", id: 6),
//   Students(name: "Gayathri", id: 7),
//   Students(name: "Hendry", id: 8),
//   Students(name: "Ishya", id: 9),
//   Students(name: "Jack", id: 10),
//   Students(name: "Jacob", id: 11),
//   Students(name: "Leuo", id: 12),
//   Students(name: "Mohan", id: 13),
//   Students(name: "Narish", id: 14),
//   Students(name: "Ondra", id: 15),
//   Students(name: "Prabu", id: 16),
// ];