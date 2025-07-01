import 'dart:async';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/route_config/route_config.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:oktoast/oktoast.dart';

Future<void> main() async {
  await configuration(runApp: () async {
    runApp(const Application());
  });
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  late StreamSubscription<User?> _authSubscription;

  @override
  void initState() {
    super.initState();
    _authSubscription = getIt<AuthService>().authStateChanges.listen((user) {
      if (user == null) {
        router.go('/login');
      } else {
        router.go('/');
      }
    });
  }

  @override
  void dispose() {
    _authSubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(402, 874),
      builder: (context, child) {
        return OKToast(
          animationCurve: Curves.easeIn,
          animationDuration: const Duration(milliseconds: 200),
          duration: const Duration(seconds: 3),
          child: MaterialApp.router(
            routerConfig: router,
            theme: ThemeData(
              bottomSheetTheme: const BottomSheetThemeData(
                backgroundColor: Colors.white,
              ),
              appBarTheme: const AppBarTheme(
                backgroundColor: Colors.white,
              ),
              navigationBarTheme: const NavigationBarThemeData(
                backgroundColor: Colors.white,
              ),
              scaffoldBackgroundColor: Colors.white,
            ),
            debugShowCheckedModeBanner: false,
            onGenerateTitle: (context) => 'Notes App',
          ),
        );
      },
    );
  }
}
