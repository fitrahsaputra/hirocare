class KabKota {
  final String id;
  final String provinceId;
  final String name;

  const KabKota({required this.id, required this.name, required this.provinceId,
  });

  KabKota.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        provinceId = json['province_id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
        "id": id,
        "province_id": provinceId,
        "name": name,
      };
}
