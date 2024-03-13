// ignore_for_file: depend_on_referenced_packages, prefer_const_constructors

import "package:dropdown_button2/dropdown_button2.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:hirocare/models/data/kab_kota.dart";
import "package:hirocare/models/data/kecamatan.dart";
import "package:hirocare/models/data/kelurahan.dart";
import "package:hirocare/services/data_daerah_service.dart";
import 'package:intl/intl.dart';
import "package:hirocare/utils/utils_provider.dart";
import "package:provider/provider.dart";

class PendaftaranPasien extends StatefulWidget {
  const PendaftaranPasien({super.key});

  @override
  State<PendaftaranPasien> createState() => _PendaftaranPasienState();
}

class _PendaftaranPasienState extends State<PendaftaranPasien> {
  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context)!.settings.arguments as String;
    final titleAppBar = agrs;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleAppBar,
          style: const TextStyle(fontSize: 14),
        ),
        elevation: 8,
      ),
      body: Consumer<UtilsProvider>(
        builder: (context, params, child) => SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black12, width: 1),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          children: [
                            SizedBox(height: 10),
                            const Text("Lengkapi Data Pasien Baru",
                                style: TextStyle(
                                    fontSize: 13, fontWeight: FontWeight.bold)),
                            const SizedBox(height: 20),
                            TextFormField(
                              controller: params.nikController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(16)
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "NIK",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              style: const TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukan NIK";
                                }
                                return null;
                              },
                            ),
                            const SizedBox(height: 10),
                            TextFormField(
                              controller: params.namaPasienController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Nama Pasien",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              style: const TextStyle(fontSize: 12),
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
                              textCapitalization: TextCapitalization.words,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukan Nama Pasien";
                                }
                                return null;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            TextFormField(
                              controller: params.tempatLahirController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Tempat Lahir",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                                FilteringTextInputFormatter.allow(
                                    RegExp(r'[a-zA-Z\s]')),
                              ],
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukan Tempat Lahir";
                                }
                                return null;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            TextFormField(
                              controller: params.dateTime == null
                                  ? null
                                  : TextEditingController(
                                      text: DateFormat('dd-MM-yyyy')
                                          .format(params.dateTime!),
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
                              onTap: params.myDate,
                              readOnly: true,
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Jenis Kelamin",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              isExpanded: true,
                              value: params.selectedGender,
                              items: params.genderOptions.map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: SizedBox(
                                    width: 100,
                                    child: Text(
                                      value,
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.normal),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  params.selectedGender = newValue!;
                                });
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Jenis Kelamin";
                                }
                                return null;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              value: params.provinsi,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Provinsi",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              isExpanded: true,
                              items: params.dataProvinsi.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Provinsi";
                                }
                                return null;
                              },
                              onChanged: (value) async {
                                setState(() {
                                  params.provinsi = value!;
                                });
                                List<KabKota> kabKotaData =
                                    await DataDaerahService()
                                        .fetchKabKota(value!);
                                setState(() {
                                  params.dataKabKota = kabKotaData;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              value: params.kabKota,
                              isExpanded: true,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Kabupaten/Kota",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Kabupaten";
                                }
                                return null;
                              },
                              items: params.dataKabKota.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) async {
                                setState(() {
                                  params.kabKota = value!;
                                });
                                List<Kecamatan> kecamatanData =
                                    await DataDaerahService()
                                        .fetchKecamatan(value!);
                                setState(() {
                                  params.dataKecamatan = kecamatanData;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Kecamatan",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              isExpanded: true,
                              value: params.kecamatan,
                              items: params.dataKecamatan.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Kecamatan";
                                }
                                return null;
                              },
                              onChanged: (value) async {
                                setState(() {
                                  params.kecamatan = value!;
                                });
                                List<Kelurahan> kelurahanData =
                                    await DataDaerahService()
                                        .fetchKelurahan(value!);
                                setState(() {
                                  params.dataKelurahan = kelurahanData;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Kelurahan",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              isExpanded: true,
                              value: params.kelurahan,
                              items: params.dataKelurahan.map((item) {
                                return DropdownMenuItem<String>(
                                  value: item.id,
                                  child: Text(
                                    item.name,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Kelurahan";
                                }
                                return null;
                              },
                              onChanged: (value) async {
                                setState(() {
                                  params.kelurahan = value!;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            TextFormField(
                              controller: params.alamatController,
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Alamat",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              inputFormatters: [
                                FilteringTextInputFormatter.singleLineFormatter,
                              ],
                              textCapitalization: TextCapitalization.words,
                              style: const TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukan Alamat";
                                }
                                return null;
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            Row(
                              children: [
                                Expanded(
                                  child: TextFormField(
                                    controller: params.rtController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "RT",
                                      labelStyle: TextStyle(fontSize: 12),
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Masukan RT";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                                const Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5)),
                                Expanded(
                                  child: TextFormField(
                                    controller: params.rwController,
                                    keyboardType: TextInputType.number,
                                    inputFormatters: <TextInputFormatter>[
                                      FilteringTextInputFormatter.digitsOnly,
                                      LengthLimitingTextInputFormatter(3)
                                    ],
                                    decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      labelText: "RW",
                                      labelStyle: TextStyle(fontSize: 12),
                                    ),
                                    style: const TextStyle(fontSize: 12),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Masukan RW";
                                      }
                                      return null;
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            DropdownButtonFormField2<String>(
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "Pilih Status Perkawinan",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              isExpanded: true,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Pilih Status Perkawinan";
                                }
                                return null;
                              },
                              value: params.selectedMarriedStatus,
                              items: params.marriedStatusOptions
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(
                                    value,
                                    style: const TextStyle(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal),
                                  ),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  params.selectedMarriedStatus = newValue!;
                                });
                              },
                            ),
                            const Padding(padding: EdgeInsets.only(top: 10)),
                            TextFormField(
                              controller: params.noHpController,
                              keyboardType: TextInputType.number,
                              inputFormatters: <TextInputFormatter>[
                                FilteringTextInputFormatter.digitsOnly,
                                LengthLimitingTextInputFormatter(13)
                              ],
                              decoration: const InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: "No Handphone",
                                labelStyle: TextStyle(fontSize: 12),
                              ),
                              style: const TextStyle(fontSize: 12),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "Masukan No Handphone";
                                }
                                return null;
                              },
                            ),
                          ],
                        )),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: 15),
                          const Text(
                            "Pilih Metode Pembayaran",
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                          const Padding(padding: EdgeInsets.only(top: 10)),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        params.selectedPaymentMethod = 'UMUM';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'UMUM',
                                          autofocus: true,
                                          groupValue:
                                              params.selectedPaymentMethod,
                                          onChanged: (String? value) {
                                            setState(() {
                                              params.selectedPaymentMethod =
                                                  value!;
                                            });
                                          },
                                        ),
                                        const Text('UMUM',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        params.selectedPaymentMethod = 'BPJS';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'BPJS',
                                          autofocus: true,
                                          groupValue:
                                              params.selectedPaymentMethod,
                                          onChanged: (String? value) {
                                            setState(() {
                                              params.selectedPaymentMethod =
                                                  value!;
                                            });
                                          },
                                        ),
                                        const Text('BPJS',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        params.selectedPaymentMethod =
                                            'ASURANSI LAINNYA';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Radio<String>(
                                          value: 'ASURANSI LAINNYA',
                                          autofocus: true,
                                          groupValue:
                                              params.selectedPaymentMethod,
                                          onChanged: (String? value) {
                                            setState(() {
                                              params.selectedPaymentMethod =
                                                  value!;
                                            });
                                          },
                                        ),
                                        const Text('ASURANSI LAINNYA',
                                            style: TextStyle(fontSize: 12)),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Padding(padding: EdgeInsets.only(top: 10)),
                    ElevatedButton(
                      onPressed: () async {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/list_poliklinik', arguments: ['Daftar Poliklinik', params]);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(double.maxFinite, 50)),
                      child: const Text(
                        'LANJUT ➡️',
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
