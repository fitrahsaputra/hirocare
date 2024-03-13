class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  late CharacterLocation origin;
  late CharacterLocation location;
  final String image;

  Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
  });

  Character.fromJson(Map<String, dynamic> json)
      : id = json['id'] as int,
        name = json['name'] as String,
        status = json['status'] as String,
        species = json['species'] as String,
        type = json['type'] as String,
        gender = json['gender'] as String,
        origin = CharacterLocation.fromJson(json['origin']),
        location = CharacterLocation.fromJson(json['location']),
        image = json['image'] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "status": status,
        "species": species,
        "type": type,
        "gender": gender,
        "origin": origin.toJson(),
        "location": location.toJson(),
        "image": image,
      };
}

class CharacterLocation {
  final String name;
  final String url;

  const CharacterLocation({required this.name, required this.url});

  factory CharacterLocation.fromJson(Map<String, dynamic> json) => CharacterLocation(
      name: json['name'] as String,
      url: json['url'] as String,
    );

  Map<String, dynamic> toJson() => {
    "name": name,
    "url": url,
  };
}