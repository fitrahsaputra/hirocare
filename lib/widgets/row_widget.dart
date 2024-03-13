import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class RowWidget extends StatelessWidget {
  final String params;
  final IconData? icon;
  final IconData? fontAwesomeIcon;
  final double? iconWidth;
  final double? fontSize;
  final FontWeight? fontWeight;
  final String url;

  const RowWidget({
    super.key,
    required this.params,
    this.icon,
    this.iconWidth,
    this.fontSize,
    this.fontWeight,
    this.fontAwesomeIcon, 
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Padding(padding: EdgeInsets.only(top: 35)),
        if (icon != null) Icon(icon),
        if (fontAwesomeIcon != null) FaIcon(fontAwesomeIcon),
        if (icon != null || fontAwesomeIcon != null) SizedBox(width: iconWidth),
        Expanded(
          child: GestureDetector(
            onTap: () {
              _launchUrl(url);
            },
            child: Text(
              params,
              style: TextStyle(
                fontSize: fontSize,
                fontWeight: fontWeight,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _launchUrl(url) async {
    final Uri link = Uri.parse(url);
    if (!await launchUrl(link)) {
      throw Exception('Gagal membuka $link');
    }
  }
}
