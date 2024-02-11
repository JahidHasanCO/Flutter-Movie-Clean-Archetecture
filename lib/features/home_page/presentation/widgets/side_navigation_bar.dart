import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/config/colors/colors.dart';

import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import '../pages/home_page.dart';

buildSideNavigationBar() {
  return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
    builder: (context, state) {
      return Row(children: [
        NavigationRail(
          selectedIndex: state.selectedIndex ?? 0,
          useIndicator: false,
          elevation: 5,
          backgroundColor: backgroundColorAddtional,
          selectedIconTheme: const IconThemeData(color: primaryColor, size: 30),
          unselectedIconTheme:
              const IconThemeData(color: textColorAddtional, size: 30),
          selectedLabelTextStyle: const TextStyle(color: primaryColor),
          unselectedLabelTextStyle: const TextStyle(color: textColorAddtional),
          extended: false,
          onDestinationSelected: (index) {
            BottomNavBarEvent selectedEvent;
            switch (index) {
              case 0:
                selectedEvent = BottomNavBarEvent.homeSelected;
                break;
              case 1:
                selectedEvent = BottomNavBarEvent.searchSelected;
                break;
              case 2:
                selectedEvent = BottomNavBarEvent.profileSelected;
                break;
              default:
                selectedEvent = BottomNavBarEvent.homeSelected;
            }
            context.read<BottomNavBarBloc>().add(selectedEvent);
          },
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.home),
              label: Text('Home'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.search),
              label: Text('Search'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.person),
              label: Text('Profile'),
            ),
          ],
        ),
        Expanded(
          child: buildBodyWithSideNavBarBloc(),
        ),
      ]);
    },
  );
}
