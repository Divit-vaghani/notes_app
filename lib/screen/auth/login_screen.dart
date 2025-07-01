import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/provider/auth/login_provider.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/widget/frosted_back_ground.dart';
// import 'package:notes_app/widget/google_button.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<LoginProvider>(
      builder: (context, value, child) => Scaffold(
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
                      'Notes App',
                      style: TextStyle(
                        fontSize: 28.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 12.h),
                    Text(
                      'Sign in to your',
                      style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Account',
                      style: TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8.h),
                    Row(
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () => router.push('/login/register'),
                          child: const Text("Sign Up"),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 16.h),
                  child: SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        NotesTextField(
                          controller: value.emailController,
                          label: 'Email',
                          hintText: 'Enter your email',
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
                        NotesTextField(
                          passwordField: true,
                          toggleVisibility: () => value.obscureTextToggle(),
                          keyboardType: TextInputType.visiblePassword,
                          controller: value.passwordController,
                          label: 'Password',
                          hintText: 'Enter your password',
                          obscureText: value.obscureText,
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
                        SizedBox(height: 12.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            TextButton(
                              onPressed: () => router.push('/login/forgot'),
                              child: const Text('Forgot Password ?'),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        PrimaryButton(
                          text: 'Log In',
                          isLoading: value.isLoading,
                          onPressed: value.login,
                        ),
                        SizedBox(height: 20.h),
                        // Row(
                        //   children: [
                        //     Expanded(child: Divider(thickness: 1.h)),
                        //     Padding(
                        //       padding: EdgeInsets.symmetric(horizontal: 10.w),
                        //       child: const Text('Or login with'),
                        //     ),
                        //     Expanded(child: Divider(thickness: 1.h)),
                        //   ],
                        // ),
                        // SizedBox(height: 20.h),
                        // GoogleButton(isLoading: value.isGoogleLoading, onPressed: value.loginWithGoogle),
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
