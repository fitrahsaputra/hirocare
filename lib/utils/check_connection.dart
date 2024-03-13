import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class CheckConnection extends GetxController {}

class NetworkController extends CheckConnection {
  final Connectivity _connectivity = Connectivity();

  @override
  void onInit() {
    super.onInit();
    _connectivity.onConnectivityChanged.listen((event) {
      if (event == ConnectivityResult.none) {
        if (!Get.isDialogOpen!) {
          Get.dialog(
            AlertDialog(
              actions: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Center(
                    child: Icon(Icons.info, size: 100, color: Colors.amber,),
                  ),
                ),
                const Text('Tidak Ada Koneksi Internet!', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                const Text(
                  'Aplikasi membutuhkan koneksi internet untuk berfungsi.',
                ),
                TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Ok'),
                ),
              ],
            ),
          );
        }
      } else {
        if (Get.isDialogOpen!) {
          Get.back();
        }
      }
    });
  }
}

class DependencyInjection extends NetworkController {
  static void init() {
    Get.put<NetworkController>(NetworkController(), permanent: true);
  }
}