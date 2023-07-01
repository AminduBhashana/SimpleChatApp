import 'package:flutter/material.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';

class LoginRegisterBtn extends StatelessWidget {
  const LoginRegisterBtn({
    super.key, required this.text, required this.press,
  });

  final String text;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return ElevatedButton(
      onPressed: (){
        press();
      }, 
      style: ElevatedButton.styleFrom(
          backgroundColor: kPrimaryColor,
          fixedSize:  Size(0.8*width, 50),
          shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))),
      child:  Text(text.toUpperCase(),style: const TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.normal),),
      );
  }
}