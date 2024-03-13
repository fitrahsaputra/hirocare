import 'package:flutter/material.dart';
import 'package:hirocare/pages/components/list_poliklinik.dart';
import 'package:hirocare/pages/components/pendaftaran_pasien.dart';
import 'package:hirocare/pages/screens/jadwal_dokter_page.dart';
import 'package:hirocare/pages/screens/pendaftaran_rawat_jalan_page.dart';
import 'package:hirocare/pages/home_page.dart';
import 'package:hirocare/pages/screens/informasi_rs_page.dart';

final Map<String, WidgetBuilder> routes = {
  '/': (context) => const HomePage(),
  '/informasi_rs': (context) => const InformasiRsPage(),
  '/jadwal_dokter': (context) => const JadwalDokterPage(),
  '/pendaftaran_rawat_jalan': (context) => const PendaftaranRawatJalanPage(),
  '/pendaftaran_pasien': (context) => const PendaftaranPasien(),
  '/list_poliklinik': (context) => const ListPoliklinik(),
};