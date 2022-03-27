import 'package:clear_architecture_practise/feature/data/repositories/person_repository_impl.dart';
import 'package:clear_architecture_practise/feature/domain/usecases/search_person.dart';
import 'package:clear_architecture_practise/feature/presentation/bloc/peson_list_cubit/person_list_cubit.dart';
import 'package:clear_architecture_practise/feature/presentation/bloc/search_bloc/search_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/platform/network_info.dart';
import 'feature/data/datasources/person_local_datasource.dart';
import 'feature/data/datasources/person_remote_datasource.dart';
import 'feature/domain/repositories/person_repository.dart';
import 'feature/domain/usecases/get_all_persons.dart';

final sl = GetIt.instance;

Future<void> init() async{
  //BloC / Cubit
  sl.registerFactory(() => PersonListCubit(getAllPersons: sl()));
  sl.registerFactory(() => PersonSearchBloc(sl()));

  //UseCases
  sl.registerLazySingleton(() => GetAllPersons(personRepository: sl()));
  sl.registerLazySingleton(() => SearchPerson(personRepository: sl()));

  // Repository
  sl.registerLazySingleton<PersonRepository>(() => PersonRepositoryImpl(
      networkInfo: sl(), localDatasource: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<PersonRemoteDataSource>(
      () => PersonRemoteDataSourceImpl(client: http.Client()));

  sl.registerLazySingleton<PersonLocalDatasource>(
      () => PersonLocalDataSourceImpl(sharedPreferences: sl()));

  //Core
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerSingleton(sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
