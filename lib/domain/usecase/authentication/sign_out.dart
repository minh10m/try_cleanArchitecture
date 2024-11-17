import 'package:clean_architecture/data/repository/authentication_repository.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class SignOutUseCase {
  AuthenticationRepository _authenticationRepository;

  SignOutUseCase(this._authenticationRepository);

  Future<void> execute() async {
    await _authenticationRepository.signOut();
  }
}