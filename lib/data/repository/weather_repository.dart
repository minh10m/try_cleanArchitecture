// weather_repository.dart
import '../model/weather/weather.dart';
import '../service/api_service.dart';

class WeatherRepository {
  late final ApiHelper apiHelper;

  // Get current weather based on user's location
  Future<Weather> getCurrentWeather() async {
    return await ApiHelper.getCurrentWeather();
  }

  // Get weather by city name
  Future<Weather> getWeatherByCityName(String cityName) async {
    return await ApiHelper.getWeatherByCityName(cityName: cityName);
  }
}
