import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:hirocare/utils/check_connection.dart';
import 'package:hirocare/utils/utils_provider.dart';
import 'package:hirocare/utils/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.init();
  runApp(
    GetMaterialApp(
      navigatorKey: navigatorKey,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id', 'ID'),
      ],
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: routes,
      builder: (context, child) {
        return ChangeNotifierProvider(
          create: (context) => UtilsProvider(navigatorKey.currentContext!),
          child: child!,
        );
      },
    ),
  );
}
