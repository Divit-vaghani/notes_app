import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/provider/auth/forgot_provider.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/widget/frosted_back_ground.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';
import 'package:provider/provider.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ForgotPasswordProvider>(
      builder: (context, value, child) => Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        backgroundColor: const Color(0xFFFDFDFD),
        body: SingleChildScrollView(
          child: Form(
            key: value.formKey,
            child: Column(
              children: [
                FrostedBackground(
                  children: [
                    SizedBox(height: 16.h),
                    Text(
                      'Forgot your\nPassword',
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
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 8.h),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotesTextField(
                          controller: value.emailController,
                          label: 'Email',
                          hintText: 'Loisbecket@gmail.com',
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
                        SizedBox(height: 32.h),
                        PrimaryButton(
                          text: 'Send',
                          isLoading: value.isLoading,
                          onPressed: value.sendResetEmail,
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
