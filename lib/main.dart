import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:simple_chat_app/Screens/Welcome/welcomeScreen.dart';
import 'package:simple_chat_app/Theme/appConstants.dart';
import 'package:simple_chat_app/models/languageConfig.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
      
    Locale currentLang =  const Locale('en','US');
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: LanguageConfig(),
      locale: currentLang,
      fallbackLocale: const Locale('en','US'),
      title: 'Simple Chat App',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home:  const WelcomeScreen(),
    );
  }
}

