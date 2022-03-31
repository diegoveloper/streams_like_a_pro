import 'dart:convert';

List<City> cityFromJson(String str) =>
    List<City>.from(json.decode(str).map((x) => City.fromJson(x)));

String cityToJson(List<City> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class City {
  City({
    required this.name,
    required this.image,
    required this.description,
  });

  final String name;
  final String image;
  final String description;

  factory City.fromJson(Map<String, dynamic> json) => City(
        name: json["name"],
        image: json["image"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "image": image,
        "description": description,
      };
}
