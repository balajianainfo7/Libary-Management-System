import 'package:flutter/material.dart';
import 'package:libary_anainfo/Categories/detailedPage.dart';

import '../../data/data_model.dart';
import '../screens/user_details_page.dart';


class UserTile extends StatelessWidget {
  final User user;

  UserTile({required this.user});

  String userTitle() {
    String title = "";
    if (user.author == "Male") {
      title = "Mr.";
    } else if (user.author == "Female") {
      title = "Ms.";
    }
    return title;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            leading: Hero(
              tag: user.id,
              child: CircleAvatar(
                backgroundImage: NetworkImage(user.image),
              ),
            ),
            title: Text('${userTitle()} ${user.title} ${user.author}'),
            subtitle: Text(user.Sname),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DetailPage(id: user.bookId.toString(),)));
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}
