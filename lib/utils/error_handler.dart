import 'package:firebase_auth/firebase_auth.dart';
import 'package:notes_app/utils/notes_toast.dart';

class AuthErrorHandler {
  static void handleAuthError(FirebaseAuthException error) {
    String message;
    switch (error.code) {
      case 'invalid-credential':
        message = 'The provided credential is invalid.';
        break;
      case 'user-not-found':
        message = 'No user found with this email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'invalid-email':
        message = 'The email address is invalid.';
        break;
      case 'user-disabled':
        message = 'This user account has been disabled.';
        break;
      case 'email-already-in-use':
        message = 'An account already exists with this email.';
        break;
      case 'weak-password':
        message = 'The password is too weak.';
        break;
      case 'operation-not-allowed':
        message = 'This operation is not allowed.';
        break;
      case 'network-request-failed':
        message = 'Network error. Please check your internet connection.';
        break;
      case 'too-many-requests':
        message = 'Too many requests. Please try again later.';
        break;
      default:
        message = 'An error occurred. Please try again.';
    }

    NotesToast.instance.errorToast(toast: message);
  }
}
