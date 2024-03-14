import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/bottom_navigation_bar_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar:
          BlocBuilder<BottomNavigationBarBloc, BottomNavigationBarState>(
        builder: (context, state) {
          if (state is BottomNavigationBarInitial) {
            return BottomNavigationBar(
              // backgroundColor: Colors.deepPurple,
              // fixedColor: Colors.deepPurple,
              selectedItemColor: Colors.deepPurpleAccent,
              unselectedItemColor: Colors.grey,
              // useLegacyColorScheme: true,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                    icon: Icon(Icons.home), label: 'Beranda'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.bookmark_added), label: 'Perjanjian'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.newspaper), label: 'Berita'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.person), label: 'Profil'),
              ],
              currentIndex: state.selectedIndex,
              onTap: (currentIndex) {
                context
                    .read<BottomNavigationBarBloc>()
                    .add(OnItemTapped(index: currentIndex));
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
