import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../../domain/usecase/authentication/get_current_user.dart';
import '../../../domain/usecase/authentication/sign_out.dart';

import '../../../domain/usecase/chat_usecases.dart';
import 'home_event.dart';
import 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final SignOutUseCase signOutUseCase;
  HomeBloc({
    required this.signOutUseCase,
  }) : super(HomeInitial()) {
    on<LogoutEvent>(_onLogout);

  }

  Future<void> _onLogout(LogoutEvent event, Emitter<HomeState> emit) async {
    try {
      await signOutUseCase.execute();
      emit(LogoutSuccess());
    } catch (error) {
      emit(LogoutFailure('Logout failed: $error'));
    }
  }
}
