part of 'bottom_navigation_bar_bloc.dart';

abstract class BottomNavigationBarEvent extends Equatable {
  const BottomNavigationBarEvent();

  @override
  List<Object> get props => [];
}

class OnItemTapped extends BottomNavigationBarEvent {
  final int index;

  const OnItemTapped({required this.index});

  @override
  List<Object> get props => [index];
}
