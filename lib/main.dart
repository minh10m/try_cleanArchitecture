import 'package:clean_architecture/presentation/bloc/weather_bloc.dart';
import 'package:clean_architecture/presentation/ui/weather_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'data/service/api_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ApiHelper apiHelper = ApiHelper();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => WeatherBloc(apiHelper),
      child: MaterialApp(
        title: 'Weather App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: CurrentWeatherScreen(),
      ),
    );
  }
}