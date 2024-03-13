import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hirocare/models/data/kab_kota.dart';
import 'package:hirocare/models/data/kecamatan.dart';
import 'package:hirocare/models/data/kelurahan.dart';
import 'package:hirocare/models/data/provinsi.dart';
import 'dart:convert';

import 'package:hirocare/models/pasien.dart';
import 'package:hirocare/services/data_daerah_service.dart';

class PasienService {
  final String _baseUrl =
      "https://65e1813da8583365b3169018.mockapi.io/rumahsakit/api/pasien";

  Future<Pasien> createPasien(List<dynamic> data) async {
    Provinsi provinsi = await DataDaerahService().fetchProvinsiById(data[5]);
    KabKota kabupaten = await DataDaerahService().fetchKabKotaById(data[6]);
    Kecamatan kecamatan = await DataDaerahService().fetchKecamatanById(data[7]);
    Kelurahan kelurahan = await DataDaerahService().fetchKelurahanById(data[8]);

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'nik': data[0] as int,
        'nama_pasien': data[1] as String,
        'tempat_lahir': data[2] as String,
        'tanggal_lahir': data[3] as String,
        'jenis_kelamin': data[4] as String,
        'provinsi': provinsi.name,
        'kabupaten': kabupaten.name,
        'kecamatan': kecamatan.name,
        'kelurahan': kelurahan.name,
        'alamat': data[9] as String,
        'rt': data[10] as int,
        'rw': data[11] as int,
        'status_perkawinan': data[12] as String,
        'no_hp': data[13] as String,
        'pembayaran': data[14] as String,
      }),
    );

    try {
      if (response.statusCode == HttpStatus.created) {
        return Pasien.fromJson(jsonDecode(response.body) as Map<String, dynamic>);
      } else {
        throw Exception('Gagal membuat data baru Pasien.');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }
}