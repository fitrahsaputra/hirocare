import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:hirocare/models/data/provinsi.dart';
import 'package:hirocare/models/data/kab_kota.dart';
import 'package:hirocare/models/data/kecamatan.dart';
import 'package:hirocare/models/data/kelurahan.dart';

class DataDaerahService {
  final String _provinsi =
      "https://emsifa.github.io/api-wilayah-indonesia/api/provinces.json";
  final String _kabKota =
      "https://emsifa.github.io/api-wilayah-indonesia/api/regencies/{provinceId}.json";
  final String _kecamatan =
      "https://emsifa.github.io/api-wilayah-indonesia/api/districts/{regencyId}.json";
  final String _kelurahan =
      "https://emsifa.github.io/api-wilayah-indonesia/api/villages/{districtId}.json";

  final String _detailProvinsi =
      'https://emsifa.github.io/api-wilayah-indonesia/api/province/{provinceId}.json';
  final String _detailKabKota =
      'https://emsifa.github.io/api-wilayah-indonesia/api/regency/{regencyId}.json';
  final String _detailKecamatan =
      'https://emsifa.github.io/api-wilayah-indonesia/api/district/{districtId}.json';
  final String _detailKelurahan =
      'https://emsifa.github.io/api-wilayah-indonesia/api/village/{villageId}.json';

  // Provinsi
  Future<List<Provinsi>> fetchProvinsi() async {
    final response = await http.get(Uri.parse(_provinsi));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Provinsi.fromJson(e)).toList();
      } else {
        throw Exception(
            'Gagal untuk memproses data Provinsi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Detail Provinsi
  Future<Provinsi> fetchProvinsiById(String provinceId) async {
    final response = await http.get(
        Uri.parse(_detailProvinsi.replaceFirst('{provinceId}', provinceId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        dynamic data = jsonDecode(response.body);
        return Provinsi.fromJson(data);
      } else {
        throw Exception(
            'Gagal untuk memproses detail data Provinsi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Kabupaten/Kota
  Future<List<KabKota>> fetchKabKota(String provinceId) async {
    final response = await http
        .get(Uri.parse(_kabKota.replaceFirst("{provinceId}", provinceId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => KabKota.fromJson(e)).toList();
      } else {
        throw Exception(
            'Gagal untuk memproses data Kabupaten/Kota: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Detail Kabupaten/Kota
  Future<KabKota> fetchKabKotaById(String regencyId) async {
    final response = await http
        .get(Uri.parse(_detailKabKota.replaceFirst("{regencyId}", regencyId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        dynamic data = jsonDecode(response.body);
        return KabKota.fromJson(data);
      } else {
        throw Exception(
            'Gagal untuk memproses detail data Kabupaten/Kota: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Kecamatan
  Future<List<Kecamatan>> fetchKecamatan(String regencyId) async {
    final response = await http
        .get(Uri.parse(_kecamatan.replaceFirst('{regencyId}', regencyId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Kecamatan.fromJson(e)).toList();
      } else {
        throw Exception(
            'Gagal untuk memproses data Kecamatan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Detail Kecamatan
  Future<Kecamatan> fetchKecamatanById(String districtId) async {
    final response = await http.get(
        Uri.parse(_detailKecamatan.replaceFirst('{districtId}', districtId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        dynamic data = jsonDecode(response.body);
        return Kecamatan.fromJson(data);
      } else {
        throw Exception(
            'Gagal untuk memproses detail data Kecamatan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Kelurahan
  Future<List<Kelurahan>> fetchKelurahan(String districtId) async {
    final response = await http
        .get(Uri.parse(_kelurahan.replaceFirst('{districtId}', districtId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        List<dynamic> data = jsonDecode(response.body);
        return data.map((e) => Kelurahan.fromJson(e)).toList();
      } else {
        throw Exception(
            'Gagal untuk memproses data Kelurahan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }

  // Detail Kelurahan
  Future<Kelurahan> fetchKelurahanById(String villageId) async {
    final response = await http.get(
        Uri.parse(_detailKelurahan.replaceFirst('{villageId}', villageId)));
    try {
      if (response.statusCode == HttpStatus.ok) {
        dynamic data = jsonDecode(response.body);
        return Kelurahan.fromJson(data);
      } else {
        throw Exception(
            'Gagal untuk memproses detail data Kelurahan: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Invalid: $e');
    }
  }
}
