import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:simple_chat_app/Screens/Components/fieldLabel.dart';
import 'package:simple_chat_app/Screens/Components/logRegBtn.dart';
import 'package:simple_chat_app/Screens/Components/textFieldForm.dart';
import 'package:simple_chat_app/Screens/Welcome/welcomeScreen.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/models/userModel.dart';

class Screen2 extends StatefulWidget {
  const Screen2({Key? key}) : super(key: key);
  
  @override
  State<Screen2> createState() => _Screen2State();  
}

class _Screen2State extends State<Screen2> {

  String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning' ;
  }
  else if (hour < 17) {
    return 'Afternoon';
  }
  else{
    return 'Evening';
  }
}
   
    TextEditingController usernameController = TextEditingController();
    late String _user = "";
    bool isLoading = true;
  
    List<String> langList = ['English', 'Sinhala'];
    String selectedLanguage = 'English';
    String? newselectedLanguage;

   _saveLanguage(String newselectedLanguage) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setString("language", newselectedLanguage); 
  }

   _getLanguage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    newselectedLanguage = sharedPreferences.getString("language") ?? selectedLanguage;  
    setState(() {
      selectedLanguage = newselectedLanguage!;
    });
  }
    
  void reFresh() async {
  String? userEmail = DataStorage.currentUser?.userEmail;
  String? username = await SQLHelper().getSingleUsername(userEmail ?? 'No user found');
  setState(() {
      _user = username!;  
     });// Print the retrieved username
}

Future<void> _updateUser(String newUsername,String oldUsername) async{
  await SQLHelper.updateUserName(
   newUsername,oldUsername);
    reFresh();
 }

 void reFreshment() async {
  String? userEmail = DataStorage.currentUser?.userEmail;
  String? username = await SQLHelper().getSingleUsername(userEmail ?? 'No user found');
  setState(() {
      _user = username!;  
     });
}

void changeLanguage(String lan){
    if(lan=="English"){
      //change to English
      var locale = const Locale('en','US');
      Get.updateLocale(locale);
    }else{
      //change to Sinhala
      var locale = const Locale('si','LK');
      Get.updateLocale(locale);
    }
  }

@override
  void initState() {
    super.initState();
    reFresh();
    reFreshment();
     _getLanguage();
    _saveLanguage(selectedLanguage);
    changeLanguage(selectedLanguage);
    
  }  

  @override
  Widget build(BuildContext context) {
     final height = MediaQuery.of(context).size.height;
     final width = MediaQuery.of(context).size.width;
     var greet = greeting();
     usernameController.text = _user ;
    
     return Scaffold(
       appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title:  Text("Good $greet! $_user",style: const TextStyle(color: kPrimaryColor,fontSize: 25,fontWeight: FontWeight.bold)),),
       body: SingleChildScrollView(
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                padding: const EdgeInsets.all(16.0),
                child:  Text("Settings".tr,style: const TextStyle(color: Colors.black,fontSize: 36,fontWeight: FontWeight.bold),),),
            ),
              SizedBox(height: 0.01*height,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child: Text("Edit Profile".tr,style: const TextStyle(fontSize: 24,color:kPrimaryColor,fontWeight: FontWeight.bold),),
              ),
              const Divider(
                color: kPrimaryLightColor,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
               SizedBox(height: 0.01*height,),
                FieldLabel(text: "Username".tr),
          TextFieldForm(
            hintText: "",
            textEditingController: usernameController,
            isObscure: false,
            textFieldType: 'Username',
          ),
          SizedBox(
            height: 0.005 * height,
          ),
          Container(
              alignment: Alignment.centerRight,
              margin: const EdgeInsets.only(right: 16),
              child: ElevatedButton(
                onPressed: () {         
                    _updateUser(usernameController.text, _user);
                    setState(() {
                      reFreshment();
                    });
                },
            style: ElevatedButton.styleFrom(
                backgroundColor: kPrimaryColor,
                fixedSize: Size(0.4 * width, 40),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15))),
            child: Text(
              "Change".tr.toUpperCase(),
              style: const TextStyle(
                  color: Colors.white, fontSize: 16, fontWeight: FontWeight.normal),
            ),
          )),
          SizedBox(height: 0.02*height,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child: Text("Change Language".tr,style: const TextStyle(fontSize: 24,color:kPrimaryColor,fontWeight: FontWeight.bold),),
              ),
              const Divider(
                color: kPrimaryLightColor,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 0.02*height,),             
              Row(           
              children:langList.map((String language) {
                return Row(
                  children: [
                    Radio<String>(
                      value: language,
                      groupValue: selectedLanguage,
                      onChanged: (String? value) {
                        setState(() {
                          selectedLanguage = value!;
                          _saveLanguage(selectedLanguage);
                          changeLanguage(selectedLanguage);
                        });
                      },
                    ),
                    Text(language,style: const TextStyle(fontSize: 18),),
                  ],
                );
              }).toList(),
              ),
              SizedBox(height: 0.01*height,),
              Text(
                '     Selected Language: $selectedLanguage'.tr,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,               
                ),
              ),
              SizedBox(height: 0.02*height,),
               Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                child: Text("Logout".tr,style: const TextStyle(fontSize: 24,color:kPrimaryColor,fontWeight: FontWeight.bold),),
              ),
              const Divider(
                color: kPrimaryLightColor,
                height: 1,
                thickness: 1,
                indent: 10,
                endIndent: 10,
              ),
              SizedBox(height: 0.05*height,),
              Center(
                child: LoginRegisterBtn(
                  text: "Logout".tr,                
                  press: () {
                    Get.offAll(const WelcomeScreen());
                },),
              ) 
           ]),
       ),
     );
  }
}

