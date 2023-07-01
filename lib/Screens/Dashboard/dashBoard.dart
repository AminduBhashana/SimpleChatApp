import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:simple_chat_app/Services/sqlHelper.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/models/userModel.dart';

import 'dScreen1.dart';
import 'dScreen2.dart';

class MyDashboard extends StatefulWidget {
  const MyDashboard({Key? key}) : super(key: key);

  @override
  State<MyDashboard> createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  
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
   
  int _currentIndex = 0;
  static  String _user = "";
  bool isLoading = true;
  
  final List<Widget> _screens = [
    const Screen1(),
    const Screen2(),
  ];

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
    reFreshment();
  }  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 24,
        backgroundColor: kPrimaryLightColor,
        selectedItemColor: kPrimaryColor,
        currentIndex: _currentIndex,
        onTap: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home,),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ]
      ),
      
    );
  }
  }




    

