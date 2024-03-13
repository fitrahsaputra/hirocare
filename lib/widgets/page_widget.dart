import 'package:flutter/material.dart';

class PageWidget extends StatelessWidget {
  final String deskripsi;

  const PageWidget({
    super.key, 
    required this.deskripsi});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Center(
        child: Text(
          deskripsi,
          style: const TextStyle(fontSize: 14),
        ),
      ),
    );
  }
}
