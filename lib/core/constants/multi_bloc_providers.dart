import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/single_child_widget.dart';

import '../../features/bottom_navigation_bar/presentation/bloc/bottom_navigation_bar_bloc.dart';
import '../../injection_container.dart';

List<SingleChildWidget> get multiBlocProviders {
  return [
    BlocProvider(
      create: (context) => locator<BottomNavigationBarBloc>(),
    )
  ];
}
