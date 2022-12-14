import 'package:flutter/material.dart';
import 'package:provider/provider.dart';



class MemberBookshelfScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),

            //Menu Title
            Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 25),
                child: Text(
                  "Your Books",
                  style: Theme.of(context).textTheme.headline2,
                ),
              ),
            ),

            SizedBox(height: 10),

            
          ],
        ),
      ),
    );
  }
}

class MyBorrowsList extends StatelessWidget {
  // final List<MemberBookIssue> myBookIssues;

  const MyBorrowsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 10),
      physics: BouncingScrollPhysics(),
      itemCount: 3,
      itemBuilder: (ctx, i) => BorrowListItem(
        status: "pening",
        bookName: "myBookIssues[i].bookName",
        bookImageUrl: "https://avatars.githubusercontent.com/u/105291343?s=40&v=4",
        authorName: "myBookIssues[i].authorName",
        issueDate: "Helper.datePresenter(myBookIssues[i].issueDate)",
        date: "",
        ),
      );
    
  }
}

class BorrowListItem extends StatelessWidget {
  final String bookName;
  final String bookImageUrl;
  final String authorName;
  final String issueDate;
  final String date;
  final  status;

  const BorrowListItem({
    Key? key,
    required this.bookName,
    required this.authorName,
    required this.issueDate,
    required this.date,
    required this.bookImageUrl,
    required this.status,
  }) : super(key: key);

  Color getIssueStatusColor() {
    switch (status) {
      case 1:
        return Colors.yellow;
      case 2:
        return Colors.red;
      default:
        return Colors.green;
    }
  }

  String getIssueStatusText(){
    switch (status) {
      case 1:
        return "PENDING";
      case 2:
        return "OVERDUE";
      default:
        return "RETURNED";
    }
  }

  IconData getIssueStatusIcon() {
    switch (status) {
      case 1:
        return Icons.timer;
      case 2:
        return Icons.error_outline;
      default:
        return Icons.check;
    }
  }

  String getDate() {
    switch (status) {
      case 1:
        return "Due on: $date";
      case 2:
        return "Was due on: $date";
      default:
        return "Returned on: $date";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8),
      height: 180,
      child: Stack(
        children: [
          //Borrow details card
          Positioned.fill(
            top: 35,
            child: Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 12, 3, 12),
                    child: Row(
                      children: [
                        SizedBox(width: 109),

                        //Borrow details
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              //Book Title
                              Flexible(
                                fit: FlexFit.loose,
                                child: Text(
                                  bookName,
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                    color: Colors.black,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              SizedBox(height: 3),

                              //Author name
                              Text(
                                "By $authorName",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),

                              SizedBox(height: 10),

                              //Issue date
                              Text(
                                "Issued on: $issueDate",
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),

                              SizedBox(height: 3),

                              //If returned, then change to return date
                              Text(
                                getDate(),
                                style: TextStyle(
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  //Status
                  Container(
                    height: double.infinity,
                    width: 32,
                    decoration: BoxDecoration(
                      color: getIssueStatusColor(),
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        bottomRight: Radius.circular(20),
                      ),
                    ),
                    child: Center(
                      child: RotatedBox(
                        quarterTurns: 3,
                        child: Text(
                          getIssueStatusText(),
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                            letterSpacing: 1.5
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          //Book Image
          Positioned(
            left: 13,
            child: Align(
              alignment: Alignment.topLeft,
              child: SizedBox(
                height: 155,
                width: 100,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: Colors.black,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  child: Image.network(
                    bookImageUrl,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            ),
          ),

          //Borrow status
          Positioned(
            right: 20,
            top: 16,
            child: Align(
              alignment: Alignment.topRight,
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(7),
                child: Icon(
                  getIssueStatusIcon(),
                  size: 22,
                  color: getIssueStatusColor(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}