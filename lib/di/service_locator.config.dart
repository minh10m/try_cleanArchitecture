// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture/data/service/api_service.dart' as _i600;
import 'package:clean_architecture/data/service/authentication.dart' as _i731;
import 'package:clean_architecture/domain/usecase/login/sign_in.dart' as _i63;
import 'package:clean_architecture/presentation/bloc/login/login_bloc.dart'
    as _i19;
import 'package:clean_architecture/presentation/bloc/weather/weather_bloc.dart'
    as _i587;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i600.ApiHelper>(() => _i600.ApiHelper());
    gh.lazySingleton<_i731.AuthenticationService>(
        () => _i731.AuthenticationService());
    gh.factory<_i587.WeatherBloc>(
        () => _i587.WeatherBloc(gh<_i600.ApiHelper>()));
    gh.lazySingleton<_i63.SignInUseCase>(
        () => _i63.SignInUseCase(gh<_i731.AuthenticationService>()));
    gh.factory<_i19.LoginBloc>(
        () => _i19.LoginBloc(signIn: gh<_i63.SignInUseCase>()));
    return this;
  }
}
