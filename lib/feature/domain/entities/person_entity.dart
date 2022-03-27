// /*
// import 'dart:convert';
//
// import 'package:equatable/equatable.dart';
//
// // PersonEntity personEntityFromJson(String str) => PersonEntity.fromJson(json.decode(str));
// //
// // String personEntityToJson(PersonEntity data) => json.encode(data.toJson());
//
// class PersonEntity extends Equatable{
//   PersonEntity({
//     required this.id,
//     required this.name,
//     required this.status,
//     required this.species,
//     required this.type,
//     required this.gender,
//     required this.origin,
//     required this.location,
//     required this.image,
//     required this.episode,
//     required this.url,
//     required this.created,
//   }) {
//     throw UnimplementedError();
//   }
//
//   final int? id;
//   final String? name;
//   final String? status;
//   final String? species;
//   final String? type;
//   final String? gender;
//   final LocationEntity? origin;
//   final LocationEntity? location;
//   final String? image;
//   final List<String>? episode;
//   final String? url;
//   final DateTime? created;
//
//   @override
//   List<Object?> get props => [id, name, status, species, type, gender, origin, location, image, episode, url, created];
// }
//
// class LocationEntity {
//   LocationEntity({
//     required this.name,
//     required this.url,
//   });
//
//   String name;
//   String url;
// }
//
// */

import 'package:equatable/equatable.dart';

class PersonEntity extends Equatable {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final LocationEntity origin;
  final LocationEntity location;
  final String image;
  final List<String> episode;
  final DateTime created;

  const PersonEntity({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.origin,
    required this.location,
    required this.image,
    required this.episode,
    required this.created,
  });

  @override
  List<Object?> get props => [
    id,
    name,
    status,
    species,
    type,
    gender,
    origin,
    location,
    image,
    episode,
    created,
  ];
}

class LocationEntity {
  final String name;
  final String url;

  const LocationEntity({required this.name, required this.url});
}