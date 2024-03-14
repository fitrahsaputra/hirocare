import 'package:get_it/get_it.dart';
import 'package:hirocare/features/bottom_navigation_bar/presentation/bloc/bottom_navigation_bar_bloc.dart';

final locator = GetIt.instance;

void setupLocator() {
  // bloc
  locator.registerFactory(() => BottomNavigationBarBloc());
}
