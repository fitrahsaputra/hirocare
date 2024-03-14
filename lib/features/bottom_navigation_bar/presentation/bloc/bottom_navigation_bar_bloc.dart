import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_navigation_bar_event.dart';
part 'bottom_navigation_bar_state.dart';

class BottomNavigationBarBloc
    extends Bloc<BottomNavigationBarEvent, BottomNavigationBarState> {
  BottomNavigationBarBloc()
      : super(const BottomNavigationBarInitial(selectedIndex: 0)) {
    on<OnItemTapped>((event, emit) {
      emit(BottomNavigationBarInitial(selectedIndex: event.index));
    });
  }
}
