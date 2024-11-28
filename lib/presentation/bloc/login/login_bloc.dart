
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import '../../../domain/usecase/authentication/sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';

@singleton
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signIn;

  LoginBloc({required this.signIn}) : super(LoginInitial()) {
    on<DoLogin>((event, emit) async {
      emit(LoginLoading());  // Show loading state
      try {
        final response = await signIn(event.email, event.password);
        print("sign in success $response");  // Handle response if needed
        emit(LoginSuccess());  // Emit success state on successful login
      } catch (e) {
        emit(LoginFailure(e.toString()));  // Emit failure state with error message
      }
    });
  }
}
