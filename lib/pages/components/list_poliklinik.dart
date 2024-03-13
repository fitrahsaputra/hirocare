import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hirocare/models/poliklinik.dart';
import 'package:hirocare/utils/utils_provider.dart';
import 'package:hirocare/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class ListPoliklinik extends StatefulWidget {
  const ListPoliklinik({super.key});

  @override
  State<ListPoliklinik> createState() => _ListPoliklinikState();
}

class _ListPoliklinikState extends State<ListPoliklinik> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final titleAppBar = args[0];
    // final dataPasienBaru = args[1];

    return Consumer<UtilsProvider>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(
            titleAppBar,
            style: const TextStyle(fontSize: 14),
          ),
          elevation: 8,
        ),
        body: Container(
          color: Colors.grey[100],
          child: FutureBuilder<List<Poliklinik>>(
            future: value.futurePoliklinik,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                if (snapshot.error is SocketException) {
                  return const Center(
                      child: TextWidget(
                    params:
                        'Tidak ada koneksi internet. Silakan periksa koneksi anda dan coba lagi.',
                    fontSize: 12,
                    textAlign: TextAlign.center,
                  ));
                } else {
                  return const Center(
                      child: Text('Poliklinik tidak ditemukan!'));
                }
              } else if (snapshot.hasData) {
                final polikliniks = snapshot.data!;
                return GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2),
                  itemCount: polikliniks.length,
                  itemBuilder: (context, index) {
                    final poliklinik = polikliniks[index];
                    return GestureDetector(
                      child: Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(10),
                            height: 160,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  height: 13,
                                ),
                                ClipRRect(
                                    // borderRadius: BorderRadius.circular(100),
                                    child: Image.network(
                                      poliklinik.logo,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: TextWidget(
                                    params: poliklinik.namaPoliklinik,
                                    fontSize: 9,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      onTap: () {
                        print('BERHASIL');
                      }
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Tidak ada poliklinik yang ditemukan.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
