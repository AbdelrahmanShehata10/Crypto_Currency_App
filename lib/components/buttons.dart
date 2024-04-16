import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';

Widget button(
{
  required String title,
  required HexColor titlecolor,
  required HexColor color,
  required double height,
  required double width,
  required String path,
  required Function function

}
    )=>GestureDetector(
  onTap: (){
    function();
  },
  child: Center(
    child:   Container(
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(4))
      ),
      height: height,
      width: width,
      child:
      Center(child:

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset("${path}",width: 5,height: 5,),
              Center(child: Text(title,style: TextStyle(color: titlecolor,fontWeight: FontWeight.w600,fontSize: 15),)),
            ],
          ),
       ),
      )),

    );

