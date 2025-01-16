part of 'weather_bloc.dart';

abstract class WeatherEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchWeather extends WeatherEvent {
  final String countryName;

  FetchWeather({required this.countryName});

  @override
  List<Object> get props => [countryName];
}

class FetchCurrentCityWeather extends WeatherEvent {
  @override
  List<Object> get props => [];
}
