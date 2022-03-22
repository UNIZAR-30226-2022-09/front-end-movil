import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  GlobalKey<FormState> loginFormKey = new GlobalKey<FormState>();
  GlobalKey<FormState> registerFormKey = new GlobalKey<FormState>();

  String email = '';
  String nick = '';
  String password = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool isValidLoginForm() {
    return loginFormKey.currentState?.validate() ?? false;
  }

  bool isValidRegisterForm() {
    return registerFormKey.currentState?.validate() ?? false;
  }
}
