import "package:flutter/material.dart";
import "package:hirocare/widgets/padding_widget.dart";

class InformasiRsPage extends StatelessWidget {
  const InformasiRsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final agrs = ModalRoute.of(context)!.settings.arguments as List<dynamic>;

    final titleAppBar = agrs[0];
    final title = agrs[1];
    final alamat = agrs[2];
    final web = agrs[3];
    final callCenter = agrs[4];
    
    int? whatsapp;
    String? telegram;
    String? facebook;
    String? instagram;
    String? youtube;

    if (agrs.length > 5) {
      whatsapp = agrs[5] as int?;
      telegram = agrs[6] as String?;
      facebook = agrs[7] as String?;
      instagram = agrs[8] as String?;
      youtube = agrs[9] as String?;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          titleAppBar,
          style: const TextStyle(fontSize: 14),
        ),
        elevation: 8,
      ),
      body: Container(
        color: Colors.grey[100],
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/images/dark_anime.jpeg',
                fit: BoxFit.contain,
              ),
              PaddingWidget(
                title: title, 
                alamat: alamat, 
                web: web, 
                callCenter: callCenter, 
                whatsapp: whatsapp,
                facebook: facebook,
                instagram: instagram,
                telegram: telegram,
                youtube: youtube,
                )
            ],
          ),
      ),
    );
  }
}
