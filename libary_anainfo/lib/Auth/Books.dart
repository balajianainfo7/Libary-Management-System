

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
class Books {
  final String id;
  final String book_info;
  final String title;
  final String returnDate;
  final String issueDate;
  final String user_id;
  final String username;
  final String author;
  
  const Books({
    required this.id,
    // required this.Sname,
    required this.title,
    // required this.isRenewed,
    required this.returnDate,
    required this.issueDate,
    required this.user_id,
    required this.username,
    required this.author,
    // required this.bookId,
    // required this.genre,
    required this.book_info,
    

  });

  factory Books.fromJson(Map<String, dynamic> json) => Books(
        id: json['book_info']['_id'].toString(),
        book_info: json['book_info']["title"].toString(),
        title: json['book_info']["title"].toString(),
        // isRenewed: json['time']?? true&&false,
        returnDate: json['book_info']["returnDate"] != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(json['book_info']["returnDate"])):null.toString(),
        issueDate: json['book_info']["issueDate"] != null ? DateFormat('dd-MM-yyyy').format(DateTime.parse(json['book_info']["issueDate"])):null.toString(),
        user_id: json['user_id']["username"].toString(),
        username: json['username'].toString(),
        author: json['book_info']['author'].toString(),
        // bookId: json['username'] as int,
        // genre: json['username'].toString(),
        // Sname: json['username'].toString(),
        
      );
}
