import '../../../injection_container.dart';
import '../presentation/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';

void homePageDIContainer() {
  locator.registerFactory<BottomNavBarBloc>(() => BottomNavBarBloc());
}
