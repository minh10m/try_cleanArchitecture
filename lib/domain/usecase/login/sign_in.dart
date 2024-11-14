import 'package:injectable/injectable.dart';

import '../../../data/model/user.dart';
import '../../../data/service/authentication.dart';

@lazySingleton
class SignInUseCase {
  AuthenticationService authenticationService;

  SignInUseCase(this.authenticationService);

  Future<User> call(String email, String password) async {
    return await authenticationService.signIn(email, password);
  }
}
