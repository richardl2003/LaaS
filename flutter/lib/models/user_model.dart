import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String username = '';
  String password = '';
  String typeOfUser = '';

  void editUsername(String user) {
    username = user;
    notifyListeners();
  }

  void editPassword(String pass) {
    password = pass;
    notifyListeners();
  }

  void editTypeOfUser(String type) {
    typeOfUser = type;
    notifyListeners();
  }

}