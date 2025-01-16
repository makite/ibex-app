import 'package:ibx_app/features/weather/data/model/current_city_model.dart';
import 'package:injectable/injectable.dart';
import 'package:ibx_app/features/weather/data/datasource/weather_data_source.dart';
import 'package:ibx_app/features/weather/data/model/weather_model.dart';
import 'package:ibx_app/injection.dart'; // Import your injection file

abstract class WeatherRepository {
  Future<WeatherModel> getWeather(String countryName);
  Future<CurrentCityModel> getCurrentCity();
}

@Injectable(as: WeatherRepository)
class WeatherRepositoryImpl implements WeatherRepository {
  @override
  Future<WeatherModel> getWeather(String countryName) async {
    try {
      // Use GetIt to fetch the WeatherRemoteDataSource instance
      return await getIt<WeatherRemoteDataSource>().getWeather(countryName);
    } catch (e) {
      rethrow; // Re-throw the exception for handling upstream
    }
  }

  Future<CurrentCityModel> getCurrentCity() async {
    try {
      // Use GetIt to fetch the WeatherRemoteDataSource instance
      return await getIt<WeatherRemoteDataSource>().getCurrentCity();
    } catch (e) {
      rethrow; // Re-throw the exception for handling upstream
    }
  }
}
