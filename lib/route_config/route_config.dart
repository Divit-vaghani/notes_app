import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:notes_app/injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/provider/note_provider.dart';
import 'package:notes_app/provider/profile_provider.dart';
import 'package:notes_app/screen/auth/forgot_screen.dart';
import 'package:notes_app/screen/auth/login_screen.dart';
import 'package:notes_app/screen/auth/register_screen.dart';
import 'package:notes_app/screen/home/home_screen.dart';
import 'package:notes_app/screen/profile/edit_profile_screen.dart';
import 'package:notes_app/screen/profile/profile_screen.dart';
import 'package:notes_app/services/auth_service.dart';
import 'package:notes_app/services/firestore_service.dart';
import 'package:notes_app/widget/notes_navigation.dart';
import 'package:provider/provider.dart';

final router = GoRouter(
  initialLocation: '/',
  redirectLimit: 1,
  redirect: (context, state) {
    final authService = getIt<AuthService>();
    final isLoggedIn = authService.isLoggedIn();
    final isAuthRoute = state.matchedLocation == '/login' || state.matchedLocation.startsWith('/login/');

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
              builder: (context, state) {
                return ChangeNotifierProvider<NoteProvider>(
                  create: (context) => NoteProvider(getIt<FirestoreService>()),
                  builder: (context, child) => const HomeScreen(),
                );
              },
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
        return ChangeNotifierProvider(
          create: (context) => ProfileProvider(userModel),
          builder: (context, child) => const EditProfileScreen(),
        );
      },
    ),
  ],
);
