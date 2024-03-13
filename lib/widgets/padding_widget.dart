import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hirocare/widgets/row_widget.dart';

class PaddingWidget extends StatelessWidget {
  final String title;
  final String alamat;
  final String web;
  final int? callCenter;
  final int? whatsapp;
  final String? telegram;
  final String? facebook;
  final String? instagram;
  final String? youtube;

  final List<String?> socialMediaLinks;

  PaddingWidget({
    super.key,
    required this.title,
    required this.alamat,
    required this.web,
    this.callCenter,
    this.whatsapp,
    this.telegram,
    this.facebook,
    this.instagram,
    this.youtube,
  }) : socialMediaLinks = [
          whatsapp?.toString(),
          telegram,
          facebook,
          instagram,
          youtube
        ];

  final String url = 'https://www.linkedin.com/in/fitrah-saputra-2b0a8a238/';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.only(left: 5, bottom: 10),
              child: Expanded(
                child: Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              )),
          RowWidget(
            params: alamat,
            icon: Icons.location_on,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: web,
            icon: Icons.link,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: callCenter.toString(),
            icon: Icons.phone,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: whatsapp.toString(),
            fontAwesomeIcon: FontAwesomeIcons.whatsapp,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: facebook.toString(),
            fontAwesomeIcon: FontAwesomeIcons.facebook,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: instagram.toString(),
            fontAwesomeIcon: FontAwesomeIcons.instagram,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: telegram.toString(),
            fontAwesomeIcon: FontAwesomeIcons.telegram,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
          RowWidget(
            params: youtube.toString(),
            fontAwesomeIcon: FontAwesomeIcons.youtube,
            iconWidth: 10,
            fontSize: 11,
            url: url,
          ),
        ],
      ),
    );
  }
}
