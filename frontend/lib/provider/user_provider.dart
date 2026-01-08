import 'package:flutter/material.dart';
import 'package:frontend/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  User _user = User(
    id: '',
    name: '',
    email: '',
    password: '',
    address: '',
    type: '',
    token: '',
  );

  User get user=>_user;


  void setUser(String user){
    _user=User.fromJson(user);
    notifyListeners();
  }
  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('x-auth-token') ?? '';

    if (token.isNotEmpty) {
      _user = _user.copyWith(token: token);
      notifyListeners();
    }
  }


}
