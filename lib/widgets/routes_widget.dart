import 'package:flutter/material.dart';

class RoutesWidget extends StatelessWidget {
  final String route;
  final String titleAppBar;
  final String title;
  final IconData icon;
  final String deskripsi;
  final MaterialColor colorIcon;
  final String? alamat;
  final String? web;
  final int? callCenter;
  final int? whatsapp;
  final String? telegram;
  final String? facebook;
  final String? instagram;
  final String? youtube;

  const RoutesWidget({
    super.key,
    required this.route,
    required this.titleAppBar,
    required this.title,
    required this.icon,
    required this.deskripsi,
    required this.colorIcon,
    this.alamat,
    this.web,
    this.callCenter,
    this.whatsapp,
    this.telegram,
    this.facebook,
    this.instagram,
    this.youtube,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, route, arguments: [
          titleAppBar,
          title,
          alamat,
          web,
          callCenter,
          whatsapp,
          telegram,
          facebook,
          instagram,
          youtube,
          deskripsi,
        ]);
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Padding(padding: EdgeInsets.zero),
                  Icon(
                    icon,
                    size: 35,
                    color: colorIcon,
                  ),
                ],
              ),
              const Padding(padding: EdgeInsets.only(top: 5)),
              Text(
                titleAppBar,
                style: const TextStyle(fontSize: 8),
                textAlign: TextAlign.center,
              ),
            ],
        ),
      ),
    );
  }
}
