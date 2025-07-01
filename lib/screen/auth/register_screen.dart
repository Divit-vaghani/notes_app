import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/provider/auth/register_provider.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/widget/frosted_back_ground.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';
import 'package:notes_app/widget/mobile_field.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: const Color(0xFFFDFDFD),
        body: SingleChildScrollView(
          child: Form(
            key: value.formKey,
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
                      InkWell(
                        onTap: () => router.pop(),
                        child: const Icon(Icons.arrow_back),
                      ),
                      SizedBox(width: 8.h),
                      const Text('Already have an account?'),
                      TextButton(onPressed: () => router.pop(), child: const Text('Sign In')),
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
                                controller: value.firstNameController,
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
                                controller: value.lastNameController,
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
                          controller: value.emailController,
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
                        MobileField(controller: value.mobileController),
                        SizedBox(height: 16.h),
                        NotesTextField(
                          passwordField: true,
                          toggleVisibility: () => value.togglePasswordVisibility(),
                          controller: value.passwordController,
                          label: 'Password',
                          hintText: '********',
                          obscureText: value.obscureTextPassword,
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
                          passwordField: true,
                          toggleVisibility: () => value.toggleConfirmPasswordVisibility(),
                          controller: value.confirmPasswordController,
                          label: 'Confirm Password',
                          hintText: '********',
                          obscureText: value.obscureTextConfirm,
                          validator: (val) {
                            if (val == null || val.isEmpty) {
                              return 'Please confirm your password';
                            }
                            if (val != value.passwordController.text) {
                              return 'Passwords do not match';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 32.h),
                        PrimaryButton(
                          text: 'Register',
                          isLoading: value.isLoading,
                          onPressed: value.register,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
