class Pasien {
  final String id;
  final int nik;
  final String namaPasien;
  final String tempatLahir;
  final String tanggalLahir;
  final String jenisKelamin;
  final String provinsi;
  final String kabupaten;
  final String kecamatan;
  final String kelurahan;
  final String alamat;
  final int rt;
  final int rw;
  final String statusPerkawinan;
  final String noHp;
  final String pembayaran;

  Pasien({
    required this.id,
    required this.nik,
    required this.namaPasien,
    required this.tempatLahir,
    required this.tanggalLahir,
    required this.jenisKelamin,
    required this.provinsi,
    required this.kabupaten,
    required this.kecamatan,
    required this.kelurahan,
    required this.alamat,
    required this.rt,
    required this.rw,
    required this.statusPerkawinan,
    required this.noHp,
    required this.pembayaran,
  });

  factory Pasien.fromJson(Map<String, dynamic> json) => Pasien(
        id: json['id'] as String,
        nik: json['nik'] as int,
        namaPasien: json['nama_pasien'] as String,
        tempatLahir: json['tempat_lahir'] as String,
        tanggalLahir: json['tanggal_lahir'] as String,
        jenisKelamin: json['jenis_kelamin'] as String,
        provinsi: json['provinsi'] as String,
        kabupaten: json['kabupaten'] as String,
        kecamatan: json['kecamatan'] as String,
        kelurahan: json['kelurahan'] as String,
        alamat: json['alamat'] as String,
        rt: json['rt'] as int,
        rw: json['rw'] as int,
        statusPerkawinan: json['status_perkawinan'] as String,
        noHp: json['no_hp'] as String,
        pembayaran: json['pembayaran'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'nik': nik,
        'nama_pasien': namaPasien,
        'tempat_lahir': tempatLahir,
        'tanggal_lahir': tanggalLahir,
        'jenis_kelamin': jenisKelamin,
        'provinsi': provinsi,
        'kabupaten': kabupaten,
        'kecamatan': kecamatan,
        'kelurahan': kelurahan,
        'alamat': alamat,
        'rt': rt,
        'rw': rw,
        'status_perkawinan': statusPerkawinan,
        'no_hp': noHp,
        'pembayaran': pembayaran,
      };
}
