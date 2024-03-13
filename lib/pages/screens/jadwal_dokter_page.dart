import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hirocare/models/character.dart';
import 'package:hirocare/utils/utils_provider.dart';
import 'package:hirocare/widgets/text_widget.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:provider/provider.dart';

class JadwalDokterPage extends StatefulWidget {
  const JadwalDokterPage({super.key});

  @override
  State<JadwalDokterPage> createState() => _JadwalDokterPageState();
}

class _JadwalDokterPageState extends State<JadwalDokterPage> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as List<dynamic>;
    final titleAppBar = args[0];

    return Consumer<UtilsProvider>(builder: (context, value, child) => 
    Scaffold(
      appBar: AppBar(
        title: value.isSearching
            ? value.buildSearchField()
            : Text(
                titleAppBar,
                style: const TextStyle(fontSize: 14),
              ),
        actions: value.buildAppBarActions(),
        elevation: 8,
      ),
      body: LiquidPullToRefresh(
        springAnimationDurationInMilliseconds: 500,
        onRefresh: value.refreshData,
        child: Container(
          color: Colors.grey[100],
          child: FutureBuilder<List<Character>>(
            future: value.futureCharacters,
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
                  return const Center(child: Text('Dokter tidak ditemukan!'));
                }
              } else if (snapshot.hasData) {
                final characters = snapshot.data!;
                return ListView.builder(
                  itemCount: characters.length,
                  itemBuilder: (context, index) {
                    final character = characters[index];
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.grey[300],
                          borderRadius: BorderRadius.circular(10)),
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        children: [
                          Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                color: const Color.fromARGB(31, 34, 34, 34),
                                width: 2,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Image.network(
                                character.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                margin: const EdgeInsets.only(left: 10),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    TextWidget(
                                        params: character.name, fontSize: 14),
                                    Text(
                                      "${character.status} - ${character.species}",
                                      style: const TextStyle(fontSize: 10),
                                    ),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 10)),
                                    Text(
                                      "Last known location:",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    TextWidget(
                                        params: character.location.name,
                                        fontSize: 12),
                                    const Padding(
                                        padding: EdgeInsets.only(bottom: 10)),
                                    Text(
                                      "First seen in:",
                                      style: TextStyle(
                                        fontSize: 10,
                                        color: Colors.grey.shade800,
                                      ),
                                    ),
                                    TextWidget(
                                        params: character.origin.name,
                                        fontSize: 12),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text('Tidak ada dokter yang ditemukan.'),
                );
              }
            },
          ),
        ),
      ),
    ),
    );
  }
}
