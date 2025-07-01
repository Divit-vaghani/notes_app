import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/utils/notes_toast.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  bool isLoading = false;
  final _authService = getIt<AuthService>();

  GlobalKey<FormState> get formKey => _formKey;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<void> sendResetEmail() async {
    if (!_formKey.currentState!.validate()) return;

    isLoading = true;
    notifyListeners();
    await _authService.sendPasswordResetEmail(emailController.text.trim());
    NotesToast.instance.successToast(
      toast: 'Password reset email sent successfully',
    );
    isLoading = false;
    notifyListeners();
    router.pop();
  }
}
