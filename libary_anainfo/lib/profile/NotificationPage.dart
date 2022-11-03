
import 'package:flutter/material.dart';
import 'package:libary_anainfo/profile/CustomTextStyle.dart';
import 'package:libary_anainfo/profile/CustomUtils.dart';


class NotificationPage extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Notifications",
          style: CustomTextStyle.textFormFieldBold.copyWith(fontSize: 18),
        ),
        leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            }),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return Dismissible(
            child: Container(
              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(14.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 3.0,
                      blurRadius: 5.0,
                    ),
                  ],
                  color: Colors.white60),
              child: Column(
                children: [
                  Container(
                    child: Align(
                      alignment: Alignment.topRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          new Icon(
                            Icons.star,
                            color: Colors.yellow,
                          ),
                          new Text("4.8")
                        ],
                      ),
                    ),
                    height: 110.0,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "https://lh3.googleusercontent.com/ogw/AOh-ky3aHGlk9akKljHoV8g59ENuuBXi8pkiTP0r9V1-ILE=s32-c-mo"),
                            fit: BoxFit.cover)),
                  ),

                  SizedBox(
                    height: 7.0,
                  ),
                  Align(
                      alignment: Alignment.topLeft,
                      child: Row(
                        children: <Widget>[
                          new Padding(
                            padding: const EdgeInsets.only(
                                right: 8.0, left: 8.0, bottom: 5.0),
                            child: new Text(
                              "\Rs.",
                              style: new TextStyle(fontSize: 14.0),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 5.0),
                            child: new Text(
                              "price.toString()",
                              style: new TextStyle(fontSize: 14.0),
                            ),
                          )
                        ],
                      )),

                  Align(
                    alignment: Alignment.topLeft,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8.0, left: 8.0),
                      child: Text(
                        "name",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'Varela',
                            fontSize: 14.0,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  //     Row(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: <Widget>[
                  //     FlutterRating(
                  //       initialRating: 4,
                  //       itemSize: 14,
                  //       itemCount: 5,
                  //       fillColor: Colors.amber,
                  //       borderColor: Colors.amber.withAlpha(50),
                  //       allowHalfRating: true,
                  //       onRatingUpdate: (rating) {},
                  //     ),
                  //     SizedBox(width: 4),
                  //     Text(
                  //       "4.5",
                  //       style: CustomTextStyle.textFormFieldMedium.copyWith(color: Colors.black, fontSize: 14),
                  //     ),
                  //   ],
                  // ),
                  Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        // isFav
                        //     ? Icon(
                        //         Icons.favorite,
                        //         color: Colors.red,
                        //       )
                        //     : Icon(
                        //         Icons.favorite_border,
                        //         color: Colors.black,
                        //       ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50.0,
                  ),
                  //   Padding(
                  //   padding: EdgeInsets.all(8.0),
                  //   child: Container(
                  //     color: Colors.white,
                  //     height: 1.0,
                  //   ),
                  // ),
                  // Padding(
                  //   padding: EdgeInsets.only(left: 5.0, right: 5.0),
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //     children: [
                  //       if (!added) ...[
                  //         Icon(
                  //           Icons.shopping_basket,
                  //           color: Colors.black,
                  //           size: 12.0,
                  //         ),
                  //         Text(
                  //           'Add to Cart',
                  //           style: TextStyle(
                  //             fontFamily: 'Varela',
                  //             color: Colors.black,
                  //             fontWeight: FontWeight.bold,
                  //             fontSize: 12.0,
                  //           ),
                  //         ),
                  //         // Icon(Icons.add_circle_outline,
                  //         // color: Colors.black,)
                  //       ],
                  //       //   if(!added)...[
                  //       //   Icon(Icons.remove_circle_outline,
                  //       //   color: Colors.black,
                  //       //   size: 12.0,),
                  //       //   Text('3',
                  //       //   style: TextStyle(
                  //       //     fontFamily: 'Varela',
                  //       //     color: Colors.black,
                  //       //     fontWeight: FontWeight.bold,
                  //       //     fontSize: 12.0,
                  //       //   ),),
                  //       //   Icon(Icons.add_circle_outline,
                  //       //   color: Colors.black,)
                  //       // ],
                  //     ],
                  //   ),
                  // ),
                ],
              ),
            ),
            key: Key("key_1"),
            direction: DismissDirection.endToStart,
            onDismissed: (DismissDirection direction) {
              getDummyList().removeAt(index);
            },
            background: Container(
              color: Colors.green,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                  Utils.getSizedBox(width: 16)
                ],
              ),
            ),
          );
        },
        itemCount: getDummyList().length,
      ),
    );
  }

  /*createItem(){
    return ListTile(
      title: Text(
        "Payment Complete",
        style: CustomTextStyle.textFormFieldBlack
            .copyWith(color: Colors.black, fontSize: 16),
      ),
      isThreeLine: true,
      trailing: IconButton(icon: Icon(Icons.close), onPressed: () {}),
      subtitle: Text(
        "Thank you for your recent payment. Your monthly subscription has been activated until June 2020.",
        softWrap: true,
        style: CustomTextStyle.textFormFieldMedium
            .copyWith(color: Colors.grey,fontSize: 14),
      ),
    );
  }*/

  static List getDummyList() {
    List list = List.generate(10, (i) {
      return "Item ${i + 1}";
    });
    return list;
  }
}
