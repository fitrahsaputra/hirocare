import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hirocare/features/bottom_navigation_bar/presentation/pages/home.dart';
import 'package:hirocare/injection_container.dart';

import 'core/constants/multi_bloc_providers.dart';

void main() {
  setupLocator();
  runApp(const HiroCare());
}

class HiroCare extends StatelessWidget {
  const HiroCare({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: multiBlocProviders,
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        home: const HomePage(),
      ),
    );
  }
}
