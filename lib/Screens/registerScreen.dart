import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Screens/Components/fieldLabel.dart';
import 'package:simple_chat_app/Screens/Components/logRegBtn.dart';
import 'package:simple_chat_app/Screens/Components/textFieldForm.dart';
import 'package:simple_chat_app/Screens/loginScreen.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/Utils/dialogBoxes.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  final _formKey =  GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isChecked = false;
  
  @override
  void initState() {
    super.initState();
  }

  Register() async{
  bool flag = false;

  void clearEmail(){
    Navigator.pop(context);
    emailController.text = '';
  }

  void changeScreen(){
      Get.off(const LoginScreen());
  }

  void clearUsername(){
    Navigator.pop(context);
    usernameController.text = '';
  }

  if (_formKey.currentState!.validate())  {
        _formKey.currentState?.save();

          if(await _searchUserEmail()){
            // ignore: use_build_context_synchronously
            showAlertDialog(context, "Account Creation Error","This email has been already Used",clearEmail);
            flag = true;           
          }
          else if(await _searchUserName()){
            // ignore: use_build_context_synchronously
            showAlertDialog(context, "Account Creation Error","This username has been already Used",clearUsername);
            flag = true;
            } 
          else if(!isChecked){
            // ignore: use_build_context_synchronously
            showAlertDialog(context, "Account Creation Error","You have to agree for our Terms of service.",clearUsername);
            flag = true;
          }
                                      
          if(!flag){
          //print(flag);
          _addUser();
          // ignore: use_build_context_synchronously
         showAlertDialog(context, "Account Creation","Your Account has been successfully created",changeScreen);
        }       
  }
      }
    Future<void> _addUser() async{
        await SQLHelper.addUser(
        emailController.text,passwordController.text,usernameController.text);
         }

    Future<bool> _searchUserEmail() async {
    List<Map<String,dynamic>> userid = [];

    final data = await SQLHelper.getUserEmail(
        emailController.text);
       userid = data;
       if(userid.length>1){
        return true;
       }else{
        return false;
       }
  }

  Future<bool> _searchUserName() async {
    List<Map<String,dynamic>> userid = [];

    final data = await SQLHelper.getUserName(
        usernameController.text);
       userid = data;
       if(userid.length>1){
        return true;
       }else{
        return false;
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
                child: Text("Create An Account",style: TextStyle(fontSize: 24,color: kPrimaryColor,fontWeight: FontWeight.bold))
                ),
              SizedBox(height: height*0.05,),
              const FieldLabel(text: "Email"),
              TextFieldForm(hintText: 'abc@gmail.com', textEditingController: emailController,isObscure: false,textFieldType: 'Email',),
              const FieldLabel(text: "Password"),
              TextFieldForm(hintText: '*********', textEditingController: passwordController,isObscure: true,textFieldType: 'Password',),
              const FieldLabel(text: "Username"),
              TextFieldForm(hintText: '', textEditingController: usernameController,isObscure: false,textFieldType: 'Username',),
              ListTile(
              title: RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: "By signing up, I understand and agree to \n",
                  style: TextStyle(color: Colors.black)
                ),
                TextSpan(
                    text: "Terms of Service.",
                    style: TextStyle(
                      color: kPrimaryColor,
                    ))
              ])),
              leading: Checkbox(
                value: isChecked,
                checkColor: Colors.white,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    isChecked = value!;
                  });
                },
              )),
              SizedBox(height: height*0.07,),
              Center(
                child: LoginRegisterBtn(
                  press: () {
                  Register();        
                },
                text: 'Create an Account',
                ),
              ),
              SizedBox(height: height*0.07,),
              InkWell(
                mouseCursor: MaterialStateMouseCursor.clickable,
                onTap: () {
                  Get.to(const LoginScreen());
                },
                hoverColor: kFocusSplashColor,
                splashColor: kFocusSplashColor,
                child: const Center(
                  child: Text("I already have an account",
                  style: TextStyle(color: kPrimaryColor,fontSize: 18,),),
                ),                    
              ),
            ]),
        ),
      ));
    
  }
}