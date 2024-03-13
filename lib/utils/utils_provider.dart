// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:hirocare/models/character.dart';
import 'package:hirocare/models/data/provinsi.dart';
import 'package:hirocare/models/pasien.dart';
import 'package:hirocare/models/poliklinik.dart';
import 'package:hirocare/services/character_service.dart';
import 'package:easy_debounce/easy_debounce.dart';
import 'package:intl/intl.dart';
import 'package:hirocare/services/data_daerah_service.dart';
import 'package:hirocare/services/pasien_service.dart';
import 'package:hirocare/services/poliklinik_service.dart';

class UtilsProvider extends ChangeNotifier {
  // Deklarasi properti
  late Future<List<Character>> _futureCharacters;
  late BuildContext _context;
  late PageController _pageController;
  late Future<List<Poliklinik>> _futurePoliklinik;
  late Future<void>? _futurePasien;

  final CharacterService _characterService = CharacterService();
  final PoliklinikService _poliklinikService = PoliklinikService();
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _noRekamMedisController = TextEditingController();
  final TextEditingController _namaPasienController = TextEditingController();
  final TextEditingController _tanggalLahirController = TextEditingController();
  final TextEditingController _nikController = TextEditingController();
  final TextEditingController _tempatLahirController = TextEditingController();
  final TextEditingController _alamatController = TextEditingController();
  final TextEditingController _rtController = TextEditingController();
  final TextEditingController _rwController = TextEditingController();
  final TextEditingController _noHpController = TextEditingController();
  final List<String> _genderOptions = ['Pria', 'Wanita'];
  final List<String> _marriedStatusOptions = [
    'Belum Menikah',
    'Menikah',
    'Cerai'
  ];

  bool _isSearching = false;
  bool _isDataCreated = false;

  int _pageIndex = 0;

  DateTime? _dateTime;

  String _search = '';
  String? _selectedPaymentMethod;
  String? _selectedGender;
  String? _selectedMarriedStatus;
  String? _provinsi;
  String? _kabKota;
  String? _kecamatan;
  String? _kelurahan;

  List<dynamic> _dataProvinsi = [];
  List<dynamic> _dataKabKota = [];
  List<dynamic> _dataKecamatan = [];
  List<dynamic> _dataKelurahan = [];

  // Getter
  TextEditingController get searchController => _searchController;
  TextEditingController get noRekamMedisController => _noRekamMedisController;
  TextEditingController get namaPasienController => _namaPasienController;
  TextEditingController get tanggalLahirController => _tanggalLahirController;
  TextEditingController get nikController => _nikController;
  TextEditingController get tempatLahirController => _tempatLahirController;
  TextEditingController get alamatController => _alamatController;
  TextEditingController get rtController => _rtController;
  TextEditingController get rwController => _rwController;
  TextEditingController get noHpController => _noHpController;

  String? get selectedPaymentMethod => _selectedPaymentMethod;
  String? get selectedGender => _selectedGender;
  String? get selectedMarriedStatus => _selectedMarriedStatus;
  String? get provinsi => _provinsi;
  String? get kabKota => _kabKota;
  String? get kecamatan => _kecamatan;
  String? get kelurahan => _kelurahan;
  String get search => _search;

  List<String> get genderOptions => _genderOptions;
  List<String> get marriedStatusOptions => _marriedStatusOptions;
  List<dynamic> get dataProvinsi => _dataProvinsi;
  List<dynamic> get dataKabKota => _dataKabKota;
  List<dynamic> get dataKecamatan => _dataKecamatan;
  List<dynamic> get dataKelurahan => _dataKelurahan;

  Future<List<Character>> get futureCharacters => _futureCharacters;
  Future<void>? get futurePasien => _futurePasien;
  Future<List<Poliklinik>> get futurePoliklinik => _futurePoliklinik;

  CharacterService get characterService => _characterService;
  PoliklinikService get poliklinikService => _poliklinikService;

  bool get isSearching => _isSearching;
  bool get isDataCreated => _isDataCreated;

  PageController get pageController => _pageController;

  int get pageIndex => _pageIndex;

  DateTime? get dateTime => _dateTime;

  // Provider mulai dari sini
  UtilsProvider(BuildContext context) {
    _context = context;
    _pageController = PageController();
    fetchCharacters(_search);
    fetchData();
    fetchPoliklinik();
    notifyListeners();
  }

  // Home Page Provider
  List<String> appBarTitles = [
    'Rumah Sakit Fitrah Saputra',
    'Perjanjian',
    'Pemberitahuan',
    'Profil',
  ];

  List<dynamic> appBarIcons = [
    null,
    Icons.bookmark_added_rounded,
    Icons.add_alert,
    Icons.person,
  ];

  void onPageChanged(int index) {
    _pageIndex = index;
    notifyListeners();
  }

  void onBottomNavTapped(int index) {
    _pageIndex = index;
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
    notifyListeners();
  }

  // Character Provider
  Future<void> fetchCharacters(String search) async {
    _futureCharacters = _characterService.fetchCharacters(search: search);
    notifyListeners();
  }

  Future<void> refreshData() async {
    fetchCharacters(_search);
  }

  void clearSearch() {
    _searchController.clear();
    _search = '';
    EasyDebounce.debounce('Debouncing', const Duration(milliseconds: 500), () {
      fetchCharacters(_search);
    });
    notifyListeners();
  }

  void onSearchChanged(String value) {
    _search = value;
    EasyDebounce.debounce('Debouncing', const Duration(milliseconds: 500), () {
      fetchCharacters(_search);
    });
    notifyListeners();
  }

  List<Widget> buildAppBarActions() {
    if (_isSearching) {
      return [
        IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: () {
            _isSearching = false;
            clearSearch();
            notifyListeners();
          },
        )
      ];
    } else {
      return [
        IconButton(
          icon: const Icon(Icons.search),
          onPressed: () {
            _isSearching = true;
            notifyListeners();
          },
        )
      ];
    }
  }

  Widget buildSearchField() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: TextField(
          autofocus: true,
          controller: _searchController,
          decoration: const InputDecoration(
              hintText: 'Search...',
              border: InputBorder.none,
              hintStyle: TextStyle(fontSize: 13)),
          onChanged: onSearchChanged,
        ),
      ),
    );
  }

  // Memilih tanggal provider
  Future<void> myDate() async {
    final DateTime? pickedDate = await showDatePicker(
      context: _context,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
      initialDate: DateTime.now(),
      locale: const Locale('id', 'ID'),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            textTheme: const TextTheme(
              labelLarge: TextStyle(fontSize: 12),
              headlineLarge: TextStyle(fontSize: 20),
              bodyLarge: TextStyle(fontSize: 12),
            ),
          ),
          child: child!,
        );
      },
    );
    if (pickedDate != null && pickedDate != _dateTime) {
      _dateTime = pickedDate;
      _tanggalLahirController.text = _dateTime != null
          ? DateFormat('dd-MM-yyyy').format(_dateTime!)
          : _tanggalLahirController.text;
      notifyListeners();
    }
  }

  // Daftar pasien provider
  set selectedGender(String? value) {
    _selectedGender = value;
    notifyListeners();
  }

  set selectedMarriedStatus(String? value) {
    _selectedMarriedStatus = value;
    notifyListeners();
  }

  set selectedPaymentMethod(String? value) {
    _selectedPaymentMethod = value;
    notifyListeners();
  }

  set provinsi(String? value) {
    _provinsi = value;
    notifyListeners();
  }

  set kabKota(value) {
    _kabKota = value;
    notifyListeners();
  }

  set kecamatan(value) {
    _kecamatan = value;
    notifyListeners();
  }

  set kelurahan(value) {
    _kelurahan = value;
    notifyListeners();
  }

  set dataKabKota(value) {
    _dataKabKota = value;
    notifyListeners();
  }

  set dataKecamatan(value) {
    _dataKecamatan = value;
    notifyListeners();
  }

  set dataKelurahan(value) {
    _dataKelurahan = value;
    notifyListeners();
  }

  set futurePasien(Future<void>? value) {
    _futurePasien = value;
    notifyListeners();
  }

  void fetchData() async {
    List<Provinsi> provinsiData = await DataDaerahService().fetchProvinsi();
    _dataProvinsi = provinsiData;
    notifyListeners();
  }

  Future<void> createPasien() async {
    final PasienService pasienService = PasienService();
    final Pasien pasien = Pasien(
      id: '',
      nik: int.parse(_nikController.text),
      namaPasien: _namaPasienController.text,
      tempatLahir: _tempatLahirController.text,
      tanggalLahir: _tanggalLahirController.text,
      jenisKelamin: _selectedGender as String,
      provinsi: _provinsi as String,
      kabupaten: _kabKota as String,
      kecamatan: _kecamatan as String,
      kelurahan: _kelurahan as String,
      alamat: _alamatController.text,
      rt: int.parse(_rtController.text),
      rw: int.parse(_rwController.text),
      statusPerkawinan: _selectedGender as String,
      noHp: _noHpController.text,
      pembayaran: _selectedPaymentMethod as String,
    );
    List<dynamic> listPasien = [
      pasien.nik,
      pasien.namaPasien,
      pasien.tempatLahir,
      pasien.tanggalLahir,
      pasien.jenisKelamin,
      pasien.provinsi,
      pasien.kabupaten,
      pasien.kecamatan,
      pasien.kelurahan,
      pasien.alamat,
      pasien.rt,
      pasien.rw,
      pasien.statusPerkawinan,
      pasien.noHp,
      pasien.pembayaran,
    ];
    await pasienService.createPasien(listPasien);
    _isDataCreated = true;
    notifyListeners();
  }

  void resetDataCreated() {
    _isDataCreated = false;
    notifyListeners();
  }

  // Poliklinik provider
  Future<void> fetchPoliklinik() async {
    _futurePoliklinik = _poliklinikService.fetchPoliklinik();
    notifyListeners();
  }
}
