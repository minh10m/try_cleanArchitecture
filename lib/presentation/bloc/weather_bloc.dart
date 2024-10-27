import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/service/api_service.dart';
import 'weather_event.dart';
import 'weather_state.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiHelper apiHelper;

  WeatherBloc(this.apiHelper) : super(WeatherInitial()) {
    on<FetchWeatherByLocation>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await ApiHelper.getCurrentWeather();
        emit(WeatherLoaded(weather));
      } on FormatException catch (e) {
        emit(WeatherError("Format error: ${e.message}"));
      } catch (e) {
        emit(WeatherError("Unexpected error: ${e.toString()}"));
      }
    });
  }
}
