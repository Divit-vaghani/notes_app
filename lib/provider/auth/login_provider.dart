import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/services/auth_service.dart';

class LoginProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool isLoading = false;
  bool isGoogleLoading = false;
  bool obscureText = true;


  void obscureTextToggle() {
    obscureText = !obscureText;
    notifyListeners();
  }


  final _authService = getIt<AuthService>();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> login() async {
    if (!_formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();
    await _authService.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
    isLoading = false;
    notifyListeners();
  }

  Future<void> loginWithGoogle() async {
    isGoogleLoading = true;
    notifyListeners();
    await _authService.signInWithGoogle();
    isGoogleLoading = false;
    notifyListeners();
  }
}