import 'package:clean_architecture/data/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

import '../../../data/model/user.dart';

@lazySingleton
class SignInUseCase {
  AuthenticationRepository authenticationRepository;

  SignInUseCase(this.authenticationRepository);

  Future<User> call(String email, String password) async {
    return await authenticationRepository.signInEmail(email, password);
  }
}
