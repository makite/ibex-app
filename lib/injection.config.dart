// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'core/services/api_client.dart' as _i4;
import 'features/weather/data/datasource/weather_data_source.dart' as _i6;
import 'features/weather/data/repositories/weather_repository.dart' as _i5;
import 'features/weather/presentation/manager/weather_bloc.dart' as _i3;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.factory<_i3.WeatherBloc>(() => _i3.WeatherBloc());
    gh.singleton<_i4.ApiClient>(() => _i4.ApiClient());
    gh.factory<_i5.WeatherRepository>(() => _i5.WeatherRepositoryImpl());
    gh.factory<_i6.WeatherRemoteDataSource>(
        () => _i6.WeatherRemoteDataSourceImpl(gh<_i4.ApiClient>()));
    return this;
  }
}
