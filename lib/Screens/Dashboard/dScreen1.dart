import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Screens/Dashboard/chatSreen.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/models/userModel.dart';

class Screen1 extends StatefulWidget {
  const Screen1({Key? key}) : super(key: key);

  @override
  State<Screen1> createState() => _Screen1State();
}

class _Screen1State extends State<Screen1> { 
  String result = DataStorage.currentUser?.userEmail ?? 'No user found'; 

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
    
    List<Map<String,dynamic>> userList = [];
    bool isLoading = true;
    late  String _user = "";

  void _refreshJournals() async {
  final data = await SQLHelper.getUsernames(DataStorage.currentUser?.userEmail ?? 'No user found' );
    setState(() {
      userList = data;
      isLoading = false;
    });  
  }

  void reFreshment() async {
  String? userEmail = DataStorage.currentUser?.userEmail;
  String? username = await SQLHelper().getSingleUsername(userEmail ?? 'No user found');
  setState(() {
      _user = username!;  
      isLoading = false;
     });// Print the retrieved username
  }

@override
  void initState() {
    super.initState();
    _refreshJournals();
    reFreshment();
  }  

  @override
  Widget build(BuildContext context) {
     var greet = greeting();
      return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title:  Text("Good $greet ! $_user",style: const TextStyle(color: kPrimaryColor,fontSize: 25,fontWeight: FontWeight.bold)),),
      body: ListView.builder(   
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Row(
              children: [
                const Icon(Icons.person,size: 40,color: kPrimaryColor,), 
                const SizedBox(width: 10,),
                Text(userList[index]['user_name'],style: const TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
              ],
            ),           
            mouseCursor: MaterialStateMouseCursor.clickable,
            tileColor: Colors.white,
            contentPadding: const EdgeInsets.only(top: 5,bottom: 5),
            shape: const Border(bottom: BorderSide(color: kPrimaryLightColor)),
            onTap: () {
             Get.to( const MyChatScreen(),arguments: userList[index]['user_name']);
            },
          );
        },
      ),
    );
  }
}