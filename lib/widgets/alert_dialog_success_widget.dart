import 'package:flutter/material.dart';

class AlertDialogSuccessWidget extends StatelessWidget {
  final String params;
  
  const AlertDialogSuccessWidget({super.key, required this.params});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: Future.delayed(const Duration(
          seconds: 2)), // Menunggu 2 detik sebelum menampilkan AlertDialog
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Menampilkan indikator loading jika masih dalam proses penundaan
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          // Menampilkan pesan kesalahan jika terjadi kesalahan saat menunggu
          return Text('Error: ${snapshot.error}');
        } else {
          // Menampilkan AlertDialog ketika penundaan selesai
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.check_circle, size: 100, color: Colors.green),
                      const SizedBox(height: 4),
                      const Text('Berhasil!',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Text('Data $params berhasil dibuat!'),
                    ],
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Ok'),
                    ),
                  ],
                );
              },
            );
          });
          return Container();
        }
      },
    );
  }
}
