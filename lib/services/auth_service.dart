import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:injectable/injectable.dart';
import 'package:notes_app/model/user_model/user_model.dart';
import 'package:notes_app/utils/error_handler.dart';

@injectable
class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Get current user
  User get currentUser {
    final user = _auth.currentUser;
    if (user == null) {
      throw Exception('User not logged in');
    }
    return user;
  }

  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // Stream of auth state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // Sign in with email and password
  Future<UserCredential?> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      AuthErrorHandler.handleAuthError(e);
      return null;
    }
  }

  // Register with email and password
  Future<UserCredential?> registerWithEmailAndPassword({
    required UserModel model,
  }) async {
    try {
      // Create user in Firebase Auth
      final userCredential = await _auth.createUserWithEmailAndPassword(
        email: model.email,
        password: model.passWord,
      );
      // Store additional user data in Firestore
      await _firestore
          .collection('USERS')
          .doc(userCredential.user?.uid)
          .set(model.toJson());
      return userCredential;
    } on FirebaseAuthException catch (e) {
      AuthErrorHandler.handleAuthError(e);
      return null;
    }
  }

  //update user data
  Future<void> updateUserData({required UserModel data}) async {
    try {
      await _firestore
          .collection('USERS')
          .doc(currentUser.uid)
          .update(data.toMapUpdateData());
    } catch (e) {
      throw Exception('Failed to update user data: $e');
    }
  }

  // Sign out
  Future<void> signOut() async {
    await _auth.signOut();
  }

  //This is Destructive method
  Future<void> deleteAccount() async {
    try {
      await _firestore
          .collection('USERS')
          .doc(currentUser.uid)
          .update({'IS_DELETED': true});
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      AuthErrorHandler.handleAuthError(e);
    } catch (e) {
      throw Exception('Failed to delete account: $e');
    }
  }

  // Get user data from Firestore
  Future<UserModel?> getUserData() async {
    try {
      final doc =
          await _firestore.collection('USERS').doc(currentUser.uid).get();
      return doc.exists ? UserModel.fromMap(doc.data()!) : null;
    } catch (e) {
      return null;
    }
  }

  // Sign in with Google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      await _googleSignIn.signOut();

      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      // Obtain the auth details from the request
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      final userCredential = await _auth.signInWithCredential(credential);

      // Check if user exists in Firestore
      final userDoc = await _firestore
          .collection('USERS')
          .doc(userCredential.user?.uid)
          .get();

      if (!userDoc.exists) {
        // Create user model from Google credentials
        final userModel = UserModel.fromUserCredential(userCredential);

        // Store user data in Firestore
        await _firestore
            .collection('USERS')
            .doc(userCredential.user?.uid)
            .set(userModel.toJson());
      }

      return userCredential;
    } on FirebaseAuthException catch (e) {
      AuthErrorHandler.handleAuthError(e);
      return null;
    } catch (e) {
      AuthErrorHandler.handleAuthError(
          FirebaseAuthException(code: 'unknown-error'));
      return null;
    }
  }

  // Update user details in Firestore
  Future<void> updateUserDetails({required UserModel userModel}) async {
    try {
      await _firestore
          .collection('USERS')
          .doc(currentUser.uid)
          .update(userModel.toJson());
    } catch (e) {
      throw Exception('Failed to update user details: $e');
    }
  }

  // Send password reset email
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(
        email: email,
      );
    } on FirebaseAuthException catch (e) {
      AuthErrorHandler.handleAuthError(e);
      rethrow;
    }
  }
}
