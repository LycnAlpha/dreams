import 'package:flutter/widgets.dart';
import 'package:dreams/Models/userModel.dart';
import 'package:dreams/resources/authMethods.dart';

class UserProvider with ChangeNotifier {
  User? _user;
  final AuthMethods _authMethods = AuthMethods();

  User get getUser => _user!;

  Future<void> refreshUser() async {
    User user = await _authMethods.getUserDetails();
    _user = user;
    notifyListeners();
  }
}
