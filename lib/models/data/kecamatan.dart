class Kecamatan {
  final String id;
  final String regencyId;
  final String name;

  const Kecamatan({required this.id, required this.name, required this.regencyId});

  Kecamatan.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        regencyId = json['regency_id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "regency_id": regencyId,
        "name": name,
      };
}
