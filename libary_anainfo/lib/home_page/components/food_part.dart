import 'package:flutter/material.dart';
import 'package:libary_anainfo/home_page/components/size_config.dart';


class FoodPart extends StatelessWidget {
  String partName;
  FoodPart({required this.partName});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: 25,
          top: 20,
          bottom: 20,
          right:  5
             /// 10.0
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(partName, style: TextStyle(decoration: TextDecoration.overline,decorationStyle: TextDecorationStyle.dotted,fontSize: SizeConfig.screenHeight!/41.18, color: Colors.black, fontWeight: FontWeight.bold),),  /// 20.0
         ElevatedButton(
                              style: ElevatedButton.styleFrom(shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50.0)),primary: Color(0xFF29B6F6),),
                                
                                child: Text(
                                  "See All",
                                  style: TextStyle(fontSize: 15.0, color: Colors.white,fontWeight: FontWeight.w700),
                                ),
                                
                                
                                onPressed: () {
                                
                                }),
             /// 32.0
        ],
      ),
    );
  }
}
