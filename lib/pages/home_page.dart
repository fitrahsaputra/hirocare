import "package:curved_labeled_navigation_bar/curved_navigation_bar.dart";
import "package:curved_labeled_navigation_bar/curved_navigation_bar_item.dart";
import "package:flutter/material.dart";
import "package:hirocare/utils/utils_provider.dart";
import "package:hirocare/widgets/carosel_widget.dart";
import "package:hirocare/widgets/page_widget.dart";
import "package:hirocare/widgets/routes_widget.dart";
import "package:provider/provider.dart";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Consumer<UtilsProvider>(builder: (context, value, child) => 
      Scaffold(
        appBar: AppBar(
          title: Text(
            value.appBarTitles[value.pageIndex], 
            style: const TextStyle(fontSize: 14),
          ),
          leading: IconButton(onPressed: () {}, icon: Icon(value.appBarIcons[value.pageIndex])),
          elevation: 100,
        ),
        bottomNavigationBar: CurvedNavigationBar(
          color: Colors.grey.shade100,
          backgroundColor: Colors.white,
          index: value.pageIndex,
          items: const [
            CurvedNavigationBarItem(
              child: Icon(Icons.home_outlined),
              label: 'Beranda',
              labelStyle: TextStyle(fontSize: 8),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.bookmark_added_rounded),
              label: 'Perjanjian',
              labelStyle: TextStyle(fontSize: 8),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.add_alert),
              label: 'Pemberitahuan',
              labelStyle: TextStyle(fontSize: 8),
            ),
            CurvedNavigationBarItem(
              child: Icon(Icons.person),
              label: 'Profil',
              labelStyle: TextStyle(fontSize: 8),
            ),
          ],
          onTap: value.onBottomNavTapped,
        ),
        body: PageView(
          controller: value.pageController,
          onPageChanged: value.onPageChanged,
          children: [
            Container(
              color: Colors.white,
              child: Center(
                child: Column(
                  children: [
                    const Padding(padding: EdgeInsets.only(top: 50)),
                    const CarouselWidget(),
                    const Padding(padding: EdgeInsets.only(bottom: 30)),
                    GridView.count(
                      padding: EdgeInsets.zero,
                      crossAxisCount: 4,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        RoutesWidget(
                          route: '/informasi_rs',
                          titleAppBar: 'Informasi',
                          title: 'Rumah Sakit Fitrah Saputra',
                          deskripsi: '',
                          icon: Icons.info,
                          colorIcon: Colors.orange,
                          alamat: 'Jl. Yang Kunanti Nanti Gg. Gak Sejahtera.',
                          web: 'rumahsakit.com',
                          callCenter: 3983274982,
                          whatsapp: 17261278368,
                          facebook: 'facebook.com/rumahsakit',
                          instagram: 'instagram.com/rumahsakit',
                          telegram: 'telegram.com/rumahsakit',
                          youtube: 'youtube.com/rumahsakit',
                        ),
                        RoutesWidget(
                          route: '/jadwal_dokter',
                          titleAppBar: 'Jadwal Dokter',
                          title: '',
                          deskripsi: '',
                          icon: Icons.person_rounded,
                          colorIcon: Colors.purple,
                        ),
                        RoutesWidget(
                          route: '/pendaftaran_rawat_jalan',
                          titleAppBar: 'Pendaftaran Rawat Jalan',
                          title: 'Pasien Baru',
                          deskripsi: 'Jika anda belum pernah berobat di Rumah Sakit Fitrah Saputra.',
                          icon: Icons.book, 
                          colorIcon: Colors.blue,
                        ),
                        // RoutesWidget(
                        //   route: '/suara_kita',
                        //   titleAppBar: 'Suara Kita',
                        //   title: 'Layanan Pengaduan Pelanggan',
                        //   deskripsi: 'Suara kita adalah layanan pengaduan pelanggan RS Fitrah Saputra kepada manajemen Rumah Sakit.',
                        //   icon: Icons.chat,
                        //   colorIcon: Colors.indigo,
                        // ),
                        // RoutesWidget(
                        //   route: '/suara_kita',
                        //   titleAppBar: 'Suara Kita',
                        //   title: 'Layanan Pengaduan Pelanggan',
                        //   deskripsi: 'Suara kita adalah layanan pengaduan pelanggan RS Fitrah Saputra kepada manajemen Rumah Sakit.',
                        //   icon: Icons.chat,
                        //   colorIcon: Colors.brown,
                        // ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const Center(
                child: PageWidget(
                  deskripsi: 'Index 1: Perjanjian',
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const Center(
                child: PageWidget(
                  deskripsi: 'Index 2: Pemberitahuan',
                ),
              ),
            ),
            Container(
              color: Colors.white,
              child: const Center(
                child: PageWidget(
                  deskripsi: 'Index 3: Profil',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}