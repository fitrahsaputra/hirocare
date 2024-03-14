part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarState extends Equatable {
  const BottomNavigationBarState();

  @override
  List<Object> get props => [];
}

class BottomNavigationBarInitial extends BottomNavigationBarState {
  final int selectedIndex;

  const BottomNavigationBarInitial({required this.selectedIndex});

  @override
  List<Object> get props => [selectedIndex];
}
