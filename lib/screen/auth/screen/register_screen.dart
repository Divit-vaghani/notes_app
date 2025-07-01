import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widget/frosted_back_ground.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';
import 'package:notes_app/widget/mobile_field.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _mobileController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isLoading = false;

  final _authService = getIt<AuthService>();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _mobileController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await _authService.registerWithEmailAndPassword(
      model: UserModel(
        countryCode: '91',
        email: _emailController.text.trim(),
        passWord: _passwordController.text.trim(),
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        mobileNumber: _mobileController.text.trim(),
      ),
    );
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              FrostedBackground(children: [
                SizedBox(height: 16.h),
                Text(
                  'Register Your\nAccount',
                  style: TextStyle(
                    fontSize: 30.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    const Text('Already have an account?'),
                    TextButton(
                        onPressed: () => router.pop(),
                        child: const Text('Sign In')),
                  ],
                ),
              ]),
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
                              controller: _firstNameController,
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
                              controller: _lastNameController,
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
                        controller: _emailController,
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
                      MobileField(controller: _mobileController),
                      SizedBox(height: 16.h),
                      NotesTextField(
                        controller: _passwordController,
                        label: 'Password',
                        hintText: '********',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your password';
                          }
                          if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 16.h),
                      NotesTextField(
                        controller: _confirmPasswordController,
                        label: 'Confirm Password',
                        hintText: '********',
                        obscureText: true,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 32.h),
                      PrimaryButton(
                        text: 'Register',
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
