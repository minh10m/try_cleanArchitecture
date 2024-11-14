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

  LoginBloc _bloc = GetIt.I<LoginBloc>();

  late String email;
  late String password;

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login page'),
      ),
      body: body(),
    );
  }

  Widget body() {
    return BlocProvider(
      create: (context) => _bloc,
      child: BlocBuilder<LoginBloc, LoginState>(
        builder: (context, state) {
          return Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [form()],
            ),
          );
        },
      ),
    );
  }

  Widget form() {
    return Column(
      children: [
        TextField(
          decoration: InputDecoration(
            labelText: 'Email',
            suffixIcon: Icon(Icons.email),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: handleEmailChange,
        ),
        SizedBox(height: 10.0),
        TextField(
          obscureText: true,
          decoration: InputDecoration(
            labelText: 'Password',
            suffixIcon: Icon(Icons.donut_small),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          onChanged: handlePasswordChange,
        ),
        ElevatedButton(child: Text('Login'), onPressed: doLogin)
      ],
    );
  }

  void doLogin() {
    _bloc.add(DoLogin(email: email, password: password));
    Navigator.pushNamed(context, '/weather');
  }

  void handleEmailChange(String value) => setState(() => email = value);

  void handlePasswordChange(String value) => setState(() => password = value);
}
