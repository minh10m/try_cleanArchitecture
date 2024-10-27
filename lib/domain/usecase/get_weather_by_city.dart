// get_weather_by_city_name_usecase.dart

import '../../data/model/weather.dart';
import '../../data/repository/weather_repository.dart';

class GetWeatherByCityNameUseCase {
  final WeatherRepository weatherRepository;

  GetWeatherByCityNameUseCase(this.weatherRepository);

  Future<Weather> call(String cityName) async {
    return await weatherRepository.getWeatherByCityName(cityName);
  }
}
