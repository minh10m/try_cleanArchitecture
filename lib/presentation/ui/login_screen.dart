import 'package:clean_architecture/presentation/bloc/login/login_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import '../bloc/login/login_event.dart';
import '../bloc/login/login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email = '';  // Khởi tạo biến email
  late String password = '';  // Khởi tạo biến password

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is LoginLoading) {
            // Hiển thị loading khi đang đăng nhập
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Logging in...")),
            );
          } else if (state is LoginSuccess) {
            // Nếu đăng nhập thành công, chuyển đến màn hình weather
            Navigator.pushReplacementNamed(context, '/home');
          } else if (state is LoginFailure) {
            // Nếu đăng nhập thất bại, hiển thị lỗi
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Login Failed: ${state.errorMessage}")),
            );
          }
        },
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              form(),
              if (email.isEmpty || password.isEmpty) ...[
                const Text(
                  'Please enter email and password to login.',
                  style: TextStyle(color: Colors.red),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(
            labelText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          onChanged: handleEmailChange,
        ),
        const SizedBox(height: 10.0),
        TextField(
          obscureText: true,
          decoration: const InputDecoration(
            labelText: 'Password',
            suffixIcon: Icon(Icons.lock),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
          ),
          onChanged: handlePasswordChange,
        ),
        const SizedBox(height: 20.0),
        ElevatedButton(
          child: const Text('Login'),
          onPressed: doLogin,
        ),
      ],
    );
  }

  void doLogin() {
    if (email.isNotEmpty && password.isNotEmpty) {
      // Gửi sự kiện login nếu email và password hợp lệ
      GetIt.I<LoginBloc>().add(DoLogin(email: email, password: password));
    } else {
      // Hiển thị thông báo nếu email hoặc password trống
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter valid email and password.')),
      );
    }
  }

  void handleEmailChange(String value) => setState(() => email = value);

  void handlePasswordChange(String value) => setState(() => password = value);
}
