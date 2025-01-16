import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ibx_app/features/weather/data/model/current_city_model.dart';
import 'package:ibx_app/features/weather/presentation/manager/weather_bloc.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:ibx_app/features/weather/data/model/weather_model.dart';
import 'package:ibx_app/features/weather/data/repositories/weather_repository.dart';
import 'package:ibx_app/injection.dart';

import 'weather_bloc_test.mocks.dart';

// Generate mocks using mockito
@GenerateMocks([WeatherRepository])
void main() {
  late MockWeatherRepository mockWeatherRepository;
  late WeatherBloc weatherBloc;

  setUp(() {
    // Register mock repository in the service locator
    mockWeatherRepository = MockWeatherRepository();
    getIt.registerSingleton<WeatherRepository>(mockWeatherRepository);

    // Initialize WeatherBloc
    weatherBloc = WeatherBloc();
  });

  tearDown(() {
    // Clear the registered singleton
    getIt.reset();
    weatherBloc.close();
  });

  group('WeatherBloc', () {
    final testWeather = WeatherModel(
      cityName: 'Test City',
      temperature: 25.0,
      description: 'Sunny',
      icon: 'ed',
    );

    test('Initial state is WeatherInitial', () {
      expect(weatherBloc.state, WeatherInitial());
    });

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchWeather is successful',
      build: () {
        // Mock getWeather response
        when(mockWeatherRepository.getWeather('Test Country'))
            .thenAnswer((_) async => testWeather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(countryName: 'Test Country')),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(mockWeatherRepository.getWeather('Test Country')).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when FetchWeather fails',
      build: () {
        // Mock getWeather to throw an exception
        when(mockWeatherRepository.getWeather('Test Country'))
            .thenThrow(Exception('Failed to fetch weather'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchWeather(countryName: 'Test Country')),
      expect: () => [
        WeatherLoading(),
        WeatherError("Some thing went wrong,Couldn't fetch weather data"),
      ],
      verify: (_) {
        verify(mockWeatherRepository.getWeather('Test Country')).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherLoaded] when FetchCurrentCityWeather is successful',
      build: () {
        // Mock getCurrentCity and getWeather responses
        when(mockWeatherRepository.getCurrentCity()).thenAnswer(
          (_) async => CurrentCityModel(
              city: 'Current City',
              ip: '',
              region: '',
              country: '',
              latitude: 37,
              longitude: 39),
        );
        when(mockWeatherRepository.getWeather('Current City'))
            .thenAnswer((_) async => testWeather);
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchCurrentCityWeather()),
      expect: () => [
        WeatherLoading(),
        WeatherLoaded(testWeather),
      ],
      verify: (_) {
        verify(mockWeatherRepository.getCurrentCity()).called(1);
        verify(mockWeatherRepository.getWeather('Current City')).called(1);
      },
    );

    blocTest<WeatherBloc, WeatherState>(
      'emits [WeatherLoading, WeatherError] when FetchCurrentCityWeather fails',
      build: () {
        // Mock getCurrentCity to throw an exception
        when(mockWeatherRepository.getCurrentCity())
            .thenThrow(Exception('Failed to fetch current city'));
        return weatherBloc;
      },
      act: (bloc) => bloc.add(FetchCurrentCityWeather()),
      expect: () => [
        WeatherLoading(),
        WeatherError("Some thing went wrong,Couldn't fetch weather data"),
      ],
      verify: (_) {
        verify(mockWeatherRepository.getCurrentCity()).called(1);
      },
    );
  });
}
