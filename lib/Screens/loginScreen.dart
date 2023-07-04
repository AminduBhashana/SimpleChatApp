import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Screens/Components/fieldLabel.dart';
import 'package:simple_chat_app/Screens/Components/logRegBtn.dart';
import 'package:simple_chat_app/Screens/Components/textFieldForm.dart';
import 'package:simple_chat_app/Screens/Dashboard/dashBoard.dart';
import 'package:simple_chat_app/Screens/registerScreen.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/Utils/dialogBoxes.dart';
import 'package:simple_chat_app/models/userModel.dart';


// ignore: must_be_immutable
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  LogIn() async {
    bool flag = false;
    
    void newInstance(){
      Navigator.pop(context);
      emailController.text = '';
      passwordController.text = '';
  }

  void accDashboard(){
    DataStorage.currentUser = User(emailController.text);
    Get.offAll(const MyDashboard());
    
  }

    if (_formKey.currentState!.validate())  {
        _formKey.currentState?.save();

          if(await _checkUserDetails()){
            // ignore: use_build_context_synchronously
            showAlertDialog(context, "Login Failed","Incorrect Email Address or Password",newInstance);
            flag = true;           
          }
                                      
          if(!flag){
          // ignore: use_build_context_synchronously
          showAlertDialog(context, "Logged","You have been successfully logged in to your account.",accDashboard);
        }       
  } 
  }

  Future<bool> _checkUserDetails() async {
    List<Map<String,dynamic>> userid = [];

    final data = await SQLHelper.checkUser(
        emailController.text,passwordController.text);
       userid = data;
       if(userid.length==1){
        return false;
       }else{
        return true;
       }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;    
    return Scaffold(
      body:  Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: height*0.1,),
              const Center(
                child: Text("Welcome Back",style: TextStyle(fontSize: 24,color: kPrimaryColor,fontWeight: FontWeight.bold))
                ),
              SizedBox(height: height*0.08,),
              const FieldLabel(text: "Email"),
              TextFieldForm(hintText: 'abc@gmail.com', textEditingController: emailController,isObscure: false,textFieldType: 'Email',),
              const FieldLabel(text: "Password"),
              TextFieldForm(hintText: '*********', textEditingController: passwordController,isObscure: true,textFieldType: 'Password',),      
              SizedBox(height: height*0.1,),
              Center(
                child: LoginRegisterBtn(
                  press: () { 
                    LogIn() ; 
                },
                text: 'Login',
                ),
              ),
              SizedBox(height: height*0.1,),
              InkWell( 
                mouseCursor: MaterialStateMouseCursor.clickable,
                onTap: () {
                  Get.to(const RegisterScreen());
                },
                hoverColor: kFocusSplashColor,
                splashColor: kFocusSplashColor,
                child: const Center(
                  child: Text("I don't have an account",
                  style: TextStyle(color: kPrimaryColor,fontSize: 18,),),
                ),
                      ),
            ]),
        ),
      ));
    
  }
}