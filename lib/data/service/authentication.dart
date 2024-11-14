import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../model/user.dart' as UserEntity;

@lazySingleton
class AuthenticationService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future<UserEntity.User> signIn(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      return UserEntity.User.createUser(email, userCredential.user?.displayName);
    } catch (e) {
      throw Exception(e);
    }
  }
}