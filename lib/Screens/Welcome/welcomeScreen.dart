import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Screens/Components/logRegBtn.dart';
import 'package:simple_chat_app/Screens/loginScreen.dart';
import 'package:simple_chat_app/Screens/registerScreen.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return  Scaffold(
       body: Column(children: [
        SizedBox(height: height*0.05,),
        Center( 
          child:  Image( 
              image:  const AssetImage(
                "assets/images/image2.png",),
              height: 0.5*height,
              width: 0.5*width,
            ),
        ),
        SizedBox(height: height*0.10,),
        LoginRegisterBtn(
          text: 'Register', 
          press: (){
            Get.off(const RegisterScreen());
          }
          ),
        SizedBox(height: height*0.04,),
        LoginRegisterBtn(
          text: 'Login', 
          press: (){
            Get.off(const LoginScreen());
          }
          ), 
  ]));
  }
}


