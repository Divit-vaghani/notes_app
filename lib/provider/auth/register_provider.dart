import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/services/auth_service.dart';

class RegisterProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final emailController = TextEditingController();
  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  bool isLoading = false;

  bool obscureTextPassword = true;
  bool obscureTextConfirm = true;

  void togglePasswordVisibility() {
    obscureTextPassword = !obscureTextPassword;
    notifyListeners();
  }

  void toggleConfirmPasswordVisibility() {
    obscureTextConfirm = !obscureTextConfirm;
    notifyListeners();
  }

  final _authService = getIt<AuthService>();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> register() async {
    if (!_formKey.currentState!.validate()) return;
    isLoading = true;
    notifyListeners();
    await _authService.registerWithEmailAndPassword(
      model: UserModel(
        countryCode: '91',
        email: emailController.text.trim(),
        passWord: passwordController.text.trim(),
        firstName: firstNameController.text.trim(),
        lastName: lastNameController.text.trim(),
        mobileNumber: mobileController.text.trim(),
      ),
    );
    isLoading = false;
    notifyListeners();
  }
}
