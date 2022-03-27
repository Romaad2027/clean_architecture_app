import 'dart:convert';

import 'package:clear_architecture_practise/core/error/exception.dart';
import 'package:clear_architecture_practise/feature/data/models/person_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PersonLocalDatasource {
  Future<List<PersonModel>> getLastPersonsFromCache();

  Future<List<String>> personsToCache(List<PersonModel> persons);
}

class PersonLocalDataSourceImpl implements PersonLocalDatasource {
  static const CACHED_PERSONS_LIST = 'CACHED_PERSONS_LIST';
  final SharedPreferences sharedPreferences;

  PersonLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<List<PersonModel>> getLastPersonsFromCache() {
    final jsonPersonsList =
        sharedPreferences.getStringList(CACHED_PERSONS_LIST);
    if (jsonPersonsList != null) {
      return Future.value(jsonPersonsList
          .map((person) => PersonModel.fromJson(json.decode(person)))
          .toList());
    } else {
      throw CacheException();
    }
  }

  @override
  Future<List<String>> personsToCache(List<PersonModel> persons) {
    final List<String> jsonPersonsList =
        persons.map((person) => json.encode(person.toJson())).toList();

    sharedPreferences.setStringList(CACHED_PERSONS_LIST, jsonPersonsList);
    return Future.value(jsonPersonsList);
  }
}
