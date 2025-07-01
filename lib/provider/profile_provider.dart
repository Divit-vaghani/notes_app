import 'package:flutter/material.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/utils/notes_toast.dart';

class ProfileProvider extends ChangeNotifier {
  late final _formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController mobileController;
  late final TextEditingController countryCodeController;
  bool _isLoading = false;

  bool get isLoading => _isLoading;
  GlobalKey<FormState> get formKey => _formKey;

  final _authService = getIt<AuthService>();

  ProfileProvider(UserModel model) {
    firstNameController = TextEditingController(text: model.firstName);
    lastNameController = TextEditingController(text: model.lastName);
    emailController = TextEditingController(text: model.email);
    mobileController = TextEditingController(text: model.mobileNumber);
    countryCodeController = TextEditingController(text: model.countryCode);
  }

  Future<void> register() async {
    try {
      if (!_formKey.currentState!.validate()) return;
      _isLoading = true;
      notifyListeners();
      await _authService.updateUserData(
        data: UserModel(
          countryCode: countryCodeController.text.trim(),
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          mobileNumber: mobileController.text.trim(),
        ),
      );
      _isLoading = false;
      notifyListeners();
      router.pop();
    } catch (e) {
      NotesToast.instance.errorToast(toast: 'Failed to update profile');
    }
  }

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    mobileController.dispose();
    countryCodeController.dispose();
    super.dispose();
  }
}
