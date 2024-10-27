import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/weather_bloc.dart';
import '../bloc/weather_event.dart';
import '../bloc/weather_state.dart';


class CurrentWeatherScreen extends StatefulWidget {
  @override
  _CurrentWeatherScreenState createState() => _CurrentWeatherScreenState();
}

class _CurrentWeatherScreenState extends State<CurrentWeatherScreen> {
  @override
  void initState() {
    super.initState();
    // Trigger weather fetch on screen load
    context.read<WeatherBloc>().add(FetchWeatherByLocation());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Current Weather'),
      ),
      body: BlocBuilder<WeatherBloc, WeatherState>(
        builder: (context, state) {
          if (state is WeatherLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WeatherLoaded) {
            final weather = state.weather;
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Location: ${weather.name}'),
                  Text('Temperature: ${weather.main?.temp?.toStringAsFixed(1) ?? 'N/A'} °C'),
                  Text('Humidity: ${weather.main?.humidity ?? 'N/A'}%'),
                  Text('Wind Speed: ${state.weather.wind?.speed ?? 'N/A'} m/s'),

                ],
              ),
            );
          } else if (state is WeatherError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('Please wait while we fetch weather data...'));
        },
      ),
    );
  }
}
