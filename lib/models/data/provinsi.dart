class Provinsi {
  final String id;
  final String name;

  const Provinsi({required this.id, required this.name});

  Provinsi.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
      };
}
