import '../../data/model/weather.dart';
import '../../data/repository/weather_repository.dart';

class GetCurrentWeatherUseCase {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherUseCase(this.weatherRepository);

  Future<Weather> call() async {
    return await weatherRepository.getCurrentWeather();
  }
}
