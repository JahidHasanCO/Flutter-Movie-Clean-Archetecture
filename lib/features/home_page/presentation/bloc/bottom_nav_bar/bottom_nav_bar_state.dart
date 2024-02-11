import 'package:equatable/equatable.dart';
import 'bottom_nav_bar_event.dart';

abstract class BottomNavBarState extends Equatable {
  final int? selectedIndex;
  final BottomNavBarEvent? selectedEvent;

  const BottomNavBarState({this.selectedIndex, this.selectedEvent});

  @override
  List<Object?> get props => [selectedIndex, selectedEvent];
}

class BottomNavBarInitialState extends BottomNavBarState {
  const BottomNavBarInitialState()
      : super(selectedIndex: 0, selectedEvent: BottomNavBarEvent.homeSelected);
}

class BottomNavBarStateUpdated extends BottomNavBarState {
  const BottomNavBarStateUpdated(
      int selectedIndex, BottomNavBarEvent selectedEvent)
      : super(selectedIndex: selectedIndex, selectedEvent: selectedEvent);
}
