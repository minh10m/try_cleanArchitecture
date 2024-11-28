// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:clean_architecture/data/repository/authentication_repository.dart'
    as _i53;
import 'package:clean_architecture/data/repository/chat_repository.dart'
    as _i254;
import 'package:clean_architecture/data/service/api_service.dart' as _i600;
import 'package:clean_architecture/data/service/authentication.dart' as _i731;
import 'package:clean_architecture/data/service/chat_service.dart' as _i147;
import 'package:clean_architecture/domain/usecase/authentication/get_current_user.dart'
    as _i783;
import 'package:clean_architecture/domain/usecase/authentication/sign_in.dart'
    as _i878;
import 'package:clean_architecture/domain/usecase/authentication/sign_out.dart'
    as _i487;
import 'package:clean_architecture/domain/usecase/chat_usecases.dart' as _i220;
import 'package:clean_architecture/presentation/bloc/chat/chat_bloc.dart'
    as _i44;
import 'package:clean_architecture/presentation/bloc/home/home_bloc.dart'
    as _i205;
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
    gh.singleton<_i147.ChatService>(() => _i147.ChatService());
    gh.lazySingleton<_i600.ApiHelper>(() => _i600.ApiHelper());
    gh.lazySingleton<_i731.AuthenticationService>(
        () => _i731.AuthenticationService());
    gh.lazySingleton<_i53.AuthenticationRepository>(
        () => _i53.AuthenticationRepository(gh<_i731.AuthenticationService>()));
    gh.lazySingleton<_i783.GetCurrentUserUseCase>(
        () => _i783.GetCurrentUserUseCase(gh<_i53.AuthenticationRepository>()));
    gh.lazySingleton<_i878.SignInUseCase>(
        () => _i878.SignInUseCase(gh<_i53.AuthenticationRepository>()));
    gh.factory<_i587.WeatherBloc>(
        () => _i587.WeatherBloc(gh<_i600.ApiHelper>()));
    gh.singleton<_i254.ChatRepository>(
        () => _i254.ChatRepository(chatService: gh<_i147.ChatService>()));
    gh.singleton<_i220.ChatUseCase>(
        () => _i220.ChatUseCase(chatRepository: gh<_i254.ChatRepository>()));
    gh.lazySingleton<_i487.SignOutUseCase>(
        () => _i487.SignOutUseCase(gh<_i53.AuthenticationRepository>()));
    gh.singleton<_i19.LoginBloc>(
        () => _i19.LoginBloc(signIn: gh<_i878.SignInUseCase>()));
    gh.singleton<_i44.ChatBloc>(
        () => _i44.ChatBloc(chatUseCase: gh<_i220.ChatUseCase>()));
    gh.factory<_i205.HomeBloc>(
        () => _i205.HomeBloc(signOutUseCase: gh<_i487.SignOutUseCase>()));
    return this;
  }
}
