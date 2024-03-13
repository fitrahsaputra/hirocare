// ignore_for_file: depend_on_referenced_packages

import "package:flutter/material.dart";
import 'package:flutter/services.dart';
import 'package:hirocare/utils/utils_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class PendaftaranRawatJalanPage extends StatefulWidget {
  const PendaftaranRawatJalanPage({super.key});

  @override
  State<PendaftaranRawatJalanPage> createState() =>
      _PendaftaranRawatJalanPageState();
}

class _PendaftaranRawatJalanPageState extends State<PendaftaranRawatJalanPage> {
  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final titleAppBar = agrs[0];
    final title = agrs[1];
    final deskripsi = agrs[10];
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Consumer<UtilsProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            titleAppBar,
            style: const TextStyle(fontSize: 14),
          ),
          elevation: 8,
        ),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: const TextStyle(
                                  fontSize: 15, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              deskripsi,
                              style: const TextStyle(fontSize: 12),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pushNamed(context, '/pendaftaran_pasien',
                                    arguments: 'Pendaftaran Pasien Baru');
                              },
                              style: ElevatedButton.styleFrom(
                                fixedSize: const Size(double.maxFinite, 50),
                              ),
                              child: const Text(
                                "+ DAFTAR PASIEN BARU",
                                style: TextStyle(fontSize: 12),
                              ),
                            ),
                            const Padding(padding: EdgeInsets.only(top: 5)),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(bottom: 20),
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Pasien yang sudah pernah berobat",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: EdgeInsets.zero,
                            child: Column(
                              children: [
                                const Text(
                                  "Cari pasien dengan nomor rekam medis yang terdaftar.",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: value.noRekamMedisController,
                                  keyboardType: TextInputType.number,
                                  inputFormatters: <TextInputFormatter>[
                                    FilteringTextInputFormatter.digitsOnly
                                  ],
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nomor rekam medis",
                                    labelStyle: TextStyle(fontSize: 12),
                                  ),
                                  style: const TextStyle(fontSize: 12),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukan nomor rekam medis";
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 10),
                                const Text("Atau", textAlign: TextAlign.center),
                                const SizedBox(height: 5),
                                const Text(
                                  "Cari pasien dengan Nama dan Tanggal Lahir sesuai KTP yang terdaftar.",
                                  style: TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                TextFormField(
                                  controller: value.namaPasienController,
                                  decoration: const InputDecoration(
                                    border: OutlineInputBorder(),
                                    labelText: "Nama Pasien",
                                    labelStyle: TextStyle(fontSize: 12),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return "Masukan nama pasien";
                                    }
                                    return null;
                                  },
                                  style: const TextStyle(fontSize: 12),
                                ),
                                const SizedBox(height: 10),
                                Row(
                                  children: [
                                    Expanded(
                                      child: TextFormField(
                                        controller: value.dateTime == null
                                            ? null
                                            : TextEditingController(
                                                text: DateFormat('dd-MM-yyyy')
                                                    .format(value.dateTime!),
                                              ),
                                        decoration: const InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: "Pilih Tanggal Lahir",
                                          labelStyle: TextStyle(fontSize: 12),
                                        ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return "Masukan tanggal lahir";
                                          }
                                          return null;
                                        },
                                        style: const TextStyle(fontSize: 12),
                                        onTap: value.myDate,
                                        readOnly: true,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 30),
                                ElevatedButton(
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {}
                                  },
                                  style: ElevatedButton.styleFrom(
                                    fixedSize: const Size(double.maxFinite, 50),
                                  ),
                                  child: const Text("Cari 🔍"),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
