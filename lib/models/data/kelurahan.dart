class Kelurahan {
  final String id;
  final String districtId;
  final String name;

  const Kelurahan({
    required this.id,
    required this.districtId,
    required this.name,
  });

  Kelurahan.fromJson(Map<String, dynamic> json)
      : id = json['id'] as String,
        districtId = json['district_id'] as String,
        name = json['name'] as String;

  Map<String, dynamic> toJson() => {
    'id': id,
    'district_id': districtId,
    'name': name
  };
}
