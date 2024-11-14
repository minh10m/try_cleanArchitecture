import 'dart:async';
import 'package:injectable/injectable.dart';
import 'package:bloc/bloc.dart';
import '../../../domain/usecase/login/sign_in.dart';
import 'login_event.dart';
import 'login_state.dart';

@injectable
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final SignInUseCase signIn;

  // Constructor
  LoginBloc({required this.signIn}) : super(LoginInitial()) {
    // Đăng ký event handler cho sự kiện DoLogin
    on<DoLogin>((event, emit) async* {
      yield LoginLoading();  // Bắt đầu quá trình đăng nhập, hiển thị Loading

      try {
        final response = await signIn(event.email, event.password); // Gọi usecase để đăng nhập
        print(response);  // Xử lý response nếu cần
        yield LoginSuccess();  // Thành công, chuyển sang màn hình tiếp theo
      } catch (e) {
        yield LoginFailure(e.toString());  // Nếu có lỗi, hiển thị lỗi
      }
    });
  }
}
