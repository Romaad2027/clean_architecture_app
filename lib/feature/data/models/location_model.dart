import 'package:clear_architecture_practise/feature/domain/entities/person_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({required String name, required String url})
      : super(name: name, url: url);

  factory LocationModel.fromJson(Map<String, dynamic> json) => LocationModel(
    name: json["name"],
    url: json["url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}
