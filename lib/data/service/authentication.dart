import 'package:clean_architecture/data/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
@lazySingleton
class AuthenticationService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  User? getCurrentUser() {
    return _firebaseAuth.currentUser;
  }

  Future<UserModel> signIn(String email, String password) async {
    try {
      // Đăng nhập bằng email và password
      UserCredential userCredential =
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);

      // Cập nhật dữ liệu người dùng trong Firestore
      await _updateUserInFirestore(userCredential.user!);

      // Trả về một đối tượng User tùy chỉnh của bạn
      return UserModel(email, password);

    } on FirebaseAuthException catch (e) {
      // Xử lý lỗi đăng nhập chi tiết hơn
      switch (e.code) {
        case 'user-not-found':
          throw Exception('User not found. Please check your email.');
        case 'wrong-password':
          throw Exception('Invalid password. Please try again.');
        default:
          throw Exception('Authentication error: ${e.message}');
      }
    } catch (e) {
      print(e.toString());
      throw Exception('An unknown error occurred: ${e.toString()}');
    }
  }

  Future<void> _updateUserInFirestore(User user) async {
    await _firestore.collection('users').doc(user.uid).set(
      {
        'email': user.email,
        'uid': user.uid,
      },
      SetOptions(merge: true), // Kết hợp với dữ liệu hiện có
    );
  }

  Future<void> signOutUser() async {
      await FirebaseAuth.instance.signOut();
  }
}