import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ibx_app/core/services/api_client.dart';
import 'package:ibx_app/features/weather/data/model/current_city_model.dart';
import 'package:ibx_app/features/weather/data/model/weather_model.dart';
import 'package:injectable/injectable.dart';

abstract class WeatherRemoteDataSource {
  Future<WeatherModel> getWeather(String countryName);
  Future<CurrentCityModel> getCurrentCity();
}

@Injectable(as: WeatherRemoteDataSource)
class WeatherRemoteDataSourceImpl implements WeatherRemoteDataSource {
  final ApiClient _apiClient;
  WeatherRemoteDataSourceImpl(this._apiClient);

  @override
  Future<WeatherModel> getWeather(String countryName) async {
    final String endpoint =
        'weather?q=$countryName&appid=${dotenv.env['API_KEY']}';

    try {
      final response = await _apiClient.get(endpoint, {}, {});

      if (response.statusCode == 200) {
        return WeatherModel.fromJson((response.data));
      } else {
        throw Exception('City not found');
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<CurrentCityModel> getCurrentCity() async {
    final response = await _apiClient.getCity('https://ipapi.co/json/', {}, {});

    if (response.statusCode == 200) {
      return CurrentCityModel.fromJson((response.data));
    } else {
      throw Exception('Failed to load city information');
    }
  }
}
