import 'package:flutter_bloc/flutter_bloc.dart';

import 'bottom_nav_bar_event.dart';
import 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(const BottomNavBarInitialState()) {
    on<BottomNavBarEvent>((event, emit) {
      emit(BottomNavBarStateUpdated(event.index, event));
    });
  }
}
