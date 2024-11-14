import 'package:clean_architecture/presentation/bloc/weather/weather_bloc.dart';
import 'package:clean_architecture/presentation/bloc/weather/weather_event.dart';
import 'package:clean_architecture/presentation/ui/login_screen.dart';
import 'package:clean_architecture/presentation/ui/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'data/service/api_service.dart';
import 'di/service_locator.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Khởi tạo Firebase
  await Firebase.initializeApp();

  // Đăng ký các dịch vụ với GetIt
  await configureDependencies();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiHelper apiHelper = ApiHelper();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/login',
        routes: {
          '/login': (context) => LoginScreen(),

          '/weather': (context) => BlocProvider<WeatherBloc>(
            create: (context) => GetIt.I<WeatherBloc>()..add(FetchWeatherByLocation()), // Cung cấp WeatherBloc ở đây
            child: CurrentWeatherScreen(),
          ),
      },
    );
  }
}