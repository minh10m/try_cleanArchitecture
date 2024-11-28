import 'package:firebase_auth/firebase_auth.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/user.dart';
import '../../../data/repository/authentication_repository.dart';

@lazySingleton
class GetCurrentUserUseCase {
  AuthenticationRepository authenticationRepository;

  GetCurrentUserUseCase(this.authenticationRepository);

  User? call() {
    return authenticationRepository.getCurrentUser();
  }
}
