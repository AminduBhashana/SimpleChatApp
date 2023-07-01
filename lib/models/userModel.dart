import 'package:flutter/foundation.dart';

class User {
  final String userEmail;

  User(this.userEmail);
}

class DataStorage {
  static User? currentUser; // Static variable to store the user data
}


