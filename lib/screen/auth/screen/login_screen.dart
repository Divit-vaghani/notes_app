import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widget/frosted_back_ground.dart';
import 'package:notes_app/widget/google_button.dart';
import 'package:notes_app/widget/notes_text_field.dart';
import 'package:notes_app/widget/primary_button.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _isGoogleLoading = false;
  bool _obscureText = true;

  final _authService = getIt<AuthService>();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    await _authService.signInWithEmailAndPassword(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );
    if (mounted) {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _loginWithGoogle() async {
    setState(() => _isGoogleLoading = true);
    await _authService.signInWithGoogle();
    if (mounted) {
      setState(() => _isGoogleLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFDFDFD),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
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
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Account',
                    style:
                        TextStyle(fontSize: 26.sp, fontWeight: FontWeight.bold),
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
                        controller: _emailController,
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
                        toggleVisibility: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        keyboardType: TextInputType.visiblePassword,
                        controller: _passwordController,
                        label: 'Password',
                        hintText: 'Enter your password',
                        obscureText: _obscureText,
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
                        isLoading: _isLoading,
                        onPressed: _login,
                      ),
                      SizedBox(height: 20.h),
                      Row(
                        children: [
                          Expanded(child: Divider(thickness: 1.h)),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 10.w),
                            child: const Text('Or login with'),
                          ),
                          Expanded(child: Divider(thickness: 1.h)),
                        ],
                      ),
                      SizedBox(height: 20.h),
                      GoogleButton(
                          isLoading: _isGoogleLoading,
                          onPressed: _loginWithGoogle),
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
