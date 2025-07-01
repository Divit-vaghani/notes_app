import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/utils/notes_toast.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';
import 'package:notes_app/widget/mobile_field.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.model});

  final UserModel model;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late final _formKey = GlobalKey<FormState>();
  late final TextEditingController firstNameController;
  late final TextEditingController lastNameController;
  late final TextEditingController emailController;
  late final TextEditingController mobileController;
  late final TextEditingController countryCodeController;
  bool _isLoading = false;

  final _authService = getIt<AuthService>();

  @override
  void initState() {
    firstNameController = TextEditingController(text: widget.model.firstName);
    lastNameController = TextEditingController(text: widget.model.lastName);
    emailController = TextEditingController(text: widget.model.email);
    mobileController = TextEditingController(text: widget.model.mobile);
    countryCodeController =
        TextEditingController(text: widget.model.countryCode);
    super.initState();
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

  Future<void> _register() async {
    try {
      if (!_formKey.currentState!.validate()) return;
      setState(() => _isLoading = true);
      await _authService.updateUserData(
        data: UserModel(
          countryCode: countryCodeController.text.trim(),
          email: emailController.text.trim(),
          firstName: firstNameController.text.trim(),
          lastName: lastNameController.text.trim(),
          mobileNumber: mobileController.text.trim(),
        ),
      );
      if (mounted) {
        setState(() => _isLoading = false);
      }
      router.pop();
    } catch (e) {
      NotesToast.instance.errorToast(toast: 'Failed to update profile');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text("Edit Profile"),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                child: SafeArea(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: NotesTextField(
                              controller: firstNameController,
                              label: 'First Name',
                              hintText: 'Lois',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your first name';
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: NotesTextField(
                              controller: lastNameController,
                              label: 'Last Name',
                              hintText: 'Becket',
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please enter your last name';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      NotesTextField(
                        readOnly: true,
                        controller: emailController,
                        label: 'Email',
                        hintText: 'jack@notes.com',
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email';
                          }
                          if (!value.contains('@')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      MobileField(
                        controller: mobileController,
                        onSelectCountry: (country) =>
                            countryCodeController.text = country.code,
                      ),
                      SizedBox(height: 32.h),
                      PrimaryButton(
                        text: 'Update',
                        isLoading: _isLoading,
                        onPressed: _register,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
