import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier{
  String username = '';
  String typeOfUser = '';

  void editUsername(String user) {
    username = user;
    notifyListeners();
  }

  void editType(String type) {
    typeOfUser = type;
  }

}