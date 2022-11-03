

import 'package:flutter/material.dart';

class Food1 {
  final String id;
  final String title;
  final int bookId;
  final String image;
  final int stock;
  final String author;
  final String description;
  final String genreid;
  final String code;
  final String Sname;
  final String genre;

  const Food1({
    required this.id,
    required this.title,
    required this.bookId,
    required this.image,
    required this.stock,
    required this.author,
    required this.description,
    required this.genreid,
    required this.code,
    required this.Sname,
    required this.genre,

  });

  factory Food1.fromJson(Map<String, dynamic> json) => Food1(
        id: json['_id'].toString(),
        title: json['title'].toString(),
        bookId: json['bookId'],
        image: json['image'].toString(),
        stock: json['stock'],
        author: json['author'].toString(),
        description: json['description'].toString(),
        genreid: json['genreid'].toString(),
        code: json['code'].toString(),
        Sname: json['Sname'].toString(),
        genre: json['genre'].toString(),
      );
}
