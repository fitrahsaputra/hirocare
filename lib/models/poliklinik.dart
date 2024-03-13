// ignore_for_file: prefer_typing_uninitialized_variables

class Poliklinik {
  final String id;
  final String namaPoliklinik;
  final logo;

  const Poliklinik({
    required this.id, 
    required this.namaPoliklinik,
    required this.logo
  });

  factory Poliklinik.fromJson(Map<String, dynamic> json) => Poliklinik(
    id: json['id'] as String, 
    namaPoliklinik: json["nama_poliklinik"] as String,
    logo: json["logo"]
  );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nama_poliklinik": namaPoliklinik,
        "logo": logo,
      };
}
