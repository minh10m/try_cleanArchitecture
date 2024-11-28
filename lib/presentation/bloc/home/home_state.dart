import 'package:firebase_auth/firebase_auth.dart';

import '../../../data/model/user.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class LogoutSuccess extends HomeState {}

class LogoutFailure extends HomeState {
  final String error;

  LogoutFailure(this.error);
}
