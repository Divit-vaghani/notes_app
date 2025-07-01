import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/screen/auth/screen/forgot_screen.dart';
import 'package:notes_app/screen/auth/screen/login_screen.dart';
import 'package:notes_app/screen/auth/screen/register_screen.dart';
import 'package:notes_app/screen/home_screen.dart';
import 'package:notes_app/screen/profile/edit_profile_screen.dart';
import 'package:notes_app/screen/profile/profile_screen.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/widget/notes_navigation.dart';

final router = GoRouter(
  initialLocation: '/',
  redirectLimit: 1,
  redirect: (context, state) {
    final authService = getIt<AuthService>();
    final isLoggedIn = authService.isLoggedIn();
    final isAuthRoute = state.matchedLocation == '/login' ||
        state.matchedLocation.startsWith('/login/');

    if (!isLoggedIn && !isAuthRoute) {
      return '/login';
    }

    if (isLoggedIn && isAuthRoute) {
      return '/';
    }

    return null;
  },
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return Scaffold(
          body: navigationShell,
          bottomNavigationBar: NotesAppNavigation(
            selectedIndex: navigationShell.currentIndex,
            onDestinationSelected: (index) {
              navigationShell.goBranch(
                index,
                initialLocation: index == navigationShell.currentIndex,
              );
            },
          ),
        );
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/',
              builder: (context, state) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              builder: (context, state) => const ProfileScreen(),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/login',
      builder: (context, state) => const LoginScreen(),
      routes: [
        GoRoute(
          path: 'register',
          builder: (context, state) => const RegisterScreen(),
        ),
        GoRoute(
          path: 'forgot',
          builder: (context, state) => const ForgotPasswordScreen(),
        ),
      ],
    ),
    GoRoute(
      path: '/edit-profile',
      builder: (context, state) {
        final userModel = state.extra as UserModel;
        return EditProfileScreen(model: userModel);
      },
    ),
  ],
);
