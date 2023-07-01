import 'package:flutter/material.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';

showAlertDialog(BuildContext context,String title,String text,VoidCallback press) {
  Widget okButton  = ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: kPrimaryColor
    ),    
    child: const Text("OK"),
    onPressed: () {
      press();
     },
  );

  AlertDialog alert = AlertDialog(
    title:  Text(title),
    content:  Text(text),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
  
}

alertDialog(BuildContext context, String msg) {
  return msg;
}