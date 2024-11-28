import 'package:clean_architecture/data/service/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';
import '../model/user.dart';

@lazySingleton
class AuthenticationRepository {
  final AuthenticationService authentication;

  AuthenticationRepository(this.authentication);

  Future<UserModel> signInEmail(String email, String password) async {
    try {
      return await authentication.signIn(email, password);
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<void> signOut() async {
    try {
      await authentication.signOutUser();
    } catch (e) {
      throw Exception('Failed to sign out: $e');
    }
  }

  User? getCurrentUser() {
    return authentication.getCurrentUser();
  }
}