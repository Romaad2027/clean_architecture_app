import 'package:clear_architecture_practise/core/error/exception.dart';
import 'package:clear_architecture_practise/core/error/failure.dart';
import 'package:clear_architecture_practise/core/platform/network_info.dart';
import 'package:clear_architecture_practise/feature/data/datasources/person_local_datasource.dart';
import 'package:clear_architecture_practise/feature/data/datasources/person_remote_datasource.dart';
import 'package:clear_architecture_practise/feature/domain/entities/person_entity.dart';
import 'package:clear_architecture_practise/feature/domain/repositories/person_repository.dart';
import 'package:dartz/dartz.dart';

import '../models/person_model.dart';

class PersonRepositoryImpl implements PersonRepository {
  final PersonRemoteDataSource remoteDataSource;
  final PersonLocalDatasource localDatasource;
  final NetworkInfo networkInfo;

  PersonRepositoryImpl(
      {required this.networkInfo,
      required this.localDatasource,
      required this.remoteDataSource});

  @override
  Future<Either<Failure, List<PersonEntity>>> getAllPersons(int page) async {
    return await _getPersons(() {
      return remoteDataSource.getAllPersons(page);
    });
  }

  @override
  Future<Either<Failure, List<PersonEntity>>> searchPerson(String query) async{
    return await _getPersons(() {
      return remoteDataSource.searchPerson(query);
    });
  }

  Future<Either<Failure, List<PersonModel>>> _getPersons(Future<List<PersonModel>> Function() getPersons) async{
    if (await networkInfo.isConnected) {
      try {
        final remotePerson = await getPersons();
        localDatasource.personsToCache(remotePerson);
        return Right(remotePerson);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      try {
        final localPerson = await localDatasource.getLastPersonsFromCache();
        return Right(localPerson);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}
