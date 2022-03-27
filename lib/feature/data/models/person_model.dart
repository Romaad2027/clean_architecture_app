import 'package:clear_architecture_practise/feature/domain/entities/person_entity.dart';

import 'location_model.dart';

class PersonModel extends PersonEntity {
  const PersonModel(
      {required int id,
      required String name,
      required String status,
      required String species,
      required String type,
      required String gender,
      required LocationEntity origin,
      required LocationEntity location,
      required String image,
      required List<String> episode,
      required DateTime created})
      : super(
            id: id,
            name: name,
            status: status,
            species: species,
            type: type,
            gender: gender,
            origin: origin,
            location: location,
            image: image,
            episode: episode,
            created: created);

  factory PersonModel.fromJson(Map<String, dynamic> json) => PersonModel(
      id: json["id"],
      name: json["name"],
      status: json["status"],
      species: json["species"],
      type: json["type"],
      gender: json["gender"],
      origin: LocationModel.fromJson(json["origin"]),
      location: LocationModel.fromJson(json["location"]),
      image: json["image"],
      episode: List<String>.from(json["episode"].map((x) => x)),
      created: DateTime.parse(json["created"]),
  );

  Map<String, dynamic> toJson() => {
      "id": id,
      "name": name,
      "status": status,
      "species": species,
      "type": type,
      "gender": gender,
      "origin": origin,
      "location": location,
      "image": image,
      "episode": List<dynamic>.from(episode.map((x) => x)),
      "created": created.toIso8601String(),
  };
}
