// service locator
import 'package:date_trivia/core/network/network_info.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/utils/input_converter.dart';
import 'features/date_trivia/data/data_sources/date_trivia_local_data_source.dart';
import 'features/date_trivia/data/data_sources/date_trivia_remote_data_source.dart';
import 'features/date_trivia/data/repositories/date_trivia_repository_impl.dart';
import 'features/date_trivia/domain/repositories/date_trivia_repository.dart';
import 'features/date_trivia/domain/usecases/get_concrete_date_trivia.dart';
import 'features/date_trivia/domain/usecases/get_random_date_trivia.dart';
import 'features/date_trivia/presentation/bloc/date_trivia_bloc.dart';
import 'package:http/http.dart' as http;

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(() => DateTriviaBloc(getConcreteDateTrivia: sl(), getRandomDateTrivia: sl(), inputConverter: sl()));

  // Use cases
  sl.registerLazySingleton(() => GetConcreteDateTrivia(sl()));
  sl.registerLazySingleton(() => GetRandomDateTrivia(sl()));
  

  // Repository
  sl.registerLazySingleton<DateTriviaRepository>(() => DateTriviaRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));
  // Data sources
  sl.registerLazySingleton<DateTriviaRemoteDataSource>(() => DateTriviaRemoteDataSourceImpl(sl()));

  sl.registerLazySingleton<DateTriviaLocalDataSource>(() => DateTriviaLocalDataSourceImpl(sl()));

  //! Core
  sl.registerLazySingleton(() => InputConverter());
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl<InternetConnectionChecker>()));

  //! External  
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
