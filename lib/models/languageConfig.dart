import 'package:get/get.dart';

class LanguageConfig extends Translations{
  @override
  Map<String, Map<String, String>> get keys=>{
    'en_US': {
      'Settings' : 'Settings',
      'Edit Profile' : 'Edit Profile',
      'Username' : 'Username',
      'Change' : 'Change',
      'Change Language':'Change Language',
      'English' : 'English',
      'Sinhala' :'Sinhala',
      'Selected Language' : 'Selected Language',
      'Logout':'Logout',
      'Register':'Register',
      'Login':'Login',
    },
    'si_LK' : {
      'Settings' : 'සැකසුම්',
      'Edit Profile' : 'පැතිකඩ සංස්කරණය',
      'Username' : 'පරිශීලක නාමය',
      'Change' : 'වෙනස් කරන්න',
      'Change Language' : 'භාෂාව වෙනස් කිරීම',
      'English':'ඉංග්‍රීසි',
      'Sinhala':'සිංහල',
      'Selected Language': 'තෝරාගත් භාෂාව',
      'Logout':'පිටවීම',
      'Register':'ලියාපදිංචි වන්න',
      'Login':'ඇතුල් වන්න',

    }
  };
}