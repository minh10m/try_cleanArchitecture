import 'package:clean_architecture/presentation/bloc/chat/chat_bloc.dart';
import 'package:clean_architecture/presentation/bloc/home/home_bloc.dart';
import 'package:clean_architecture/presentation/bloc/login/login_bloc.dart';
import 'package:clean_architecture/presentation/bloc/weather/weather_bloc.dart';
import 'package:clean_architecture/presentation/bloc/weather/weather_event.dart';
import 'package:clean_architecture/presentation/ui/home_page.dart';
import 'package:clean_architecture/presentation/ui/login_screen.dart';
import 'package:clean_architecture/presentation/ui/weather_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

import 'data/service/api_service.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  final ApiHelper apiHelper = ApiHelper();

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<LoginBloc>(create: (context) => GetIt.I<LoginBloc>()),
        BlocProvider<WeatherBloc>(create: (context) => GetIt.I<WeatherBloc>()..add(FetchWeatherByLocation())),
        BlocProvider<HomeBloc>(create: (context) => GetIt.I<HomeBloc>()),
        BlocProvider<ChatBloc>(create: (context) => GetIt.I<ChatBloc>()),
      ],
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),
          '/weather': (context) => CurrentWeatherScreen(),
          '/home': (context) => HomePage(),
        },
      ),
    );
  }
}