import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget NormalTextfield({
  required Icon icon,
  required MaterialColor iconcolor,
  required String hintText,
  required TextEditingController email,

})=>TextField(
  controller: email,
  decoration: InputDecoration(
    icon: icon,
    iconColor: iconcolor,
    border: OutlineInputBorder(),
    hintText: hintText,
  ),
);
Widget PasswordTextfield({
  required TextEditingController password,

  required Icon icon,
  required MaterialColor iconcolor,
  required String hintText
}) {
  return TextField(
    controller: password,
onChanged: (value){

},
obscureText: true,
obscuringCharacter: "*",
decoration: InputDecoration(
border: OutlineInputBorder(),
hintText: hintText,
icon:icon,
iconColor: iconcolor,
));
}
Widget TitleText(
{
  required String Title,
  required double fontsize
}
    )=>Text(Title,style: TextStyle(
    fontSize: fontsize,
    fontWeight: FontWeight.bold

));


