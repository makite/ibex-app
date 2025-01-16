import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:ibx_app/features/weather/data/model/weather_model.dart';
import 'package:ibx_app/injection.dart'; // Make sure to import your injection file
import '../../data/repositories/weather_repository.dart';

part 'weather_event.dart';
part 'weather_state.dart';

@injectable
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()) {
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather =
            await getIt<WeatherRepository>().getWeather(event.countryName);
        emit(WeatherLoaded(weather));
      } catch (e) {
        print(e);
        emit(WeatherError("Some thing went wrong,Couldn't fetch weather data"));
      }
    });
    on<FetchCurrentCityWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final cityInfo = await getIt<WeatherRepository>().getCurrentCity();
        final weather =
            await getIt<WeatherRepository>().getWeather(cityInfo.city);
        emit(WeatherLoaded(weather));
      } catch (e) {
        emit(WeatherError("Some thing went wrong,Couldn't fetch weather data"));
      }
    });
  }
}
