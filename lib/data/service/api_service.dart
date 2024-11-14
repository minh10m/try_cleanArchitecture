
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../model/weather/weather.dart';
import 'geoloactor.dart';

@lazySingleton
class ApiHelper{
  static const apiKey = '9d2262df33f285e5736d6be95c7d4b1d';
  static const baseUrl = 'https://api.openweathermap.org/data/2.5';

  static double lat = 0.0;
  static double lon = 0.0;

  static final dio = new Dio();

  static Future<void> fetchLocation() async {
    final location = await getLocation();
    lat = location.latitude;
    lon = location.longitude;
  }

  static Future<Weather> getCurrentWeather() async {
    await fetchLocation();

    final url = constructWeatherUrl();
    final response = await fetchData(url);
    print("Raw response data: $response");

    // Deserialize JSON into Weather object
    final weather = Weather.fromJson(response);
    return weather;
  }

  static Future<Weather> getWeatherByCityName({required String cityName}) async{
    final url = constructWeatherByCityUrl(cityName);
    final response = await fetchData(url);
    return Weather.fromJson(response);
  }

  static String constructWeatherUrl() =>
      '$baseUrl/weather?lat=$lat&lon=$lon&units=metric&appid=${apiKey}';


  static String constructWeatherByCityUrl(String city) =>
      '$baseUrl/weather?q=$city&units=metric&appid=${apiKey}';


  static Future<Map<String, dynamic>> fetchData(String url) async{
    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        return response.data;
      } else {
        print('Failed to load data ${response.statusCode}');
        throw Exception('Failed to load data from the API');
      }
    } catch (error) {
      print('Error fetching data $url');
      throw Exception('Failed to fetch data from the API');
    }

  }

}