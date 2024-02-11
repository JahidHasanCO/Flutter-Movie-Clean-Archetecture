import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/config/colors/colors.dart';

import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';

buildBottomNavigationBar() {
  return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
    builder: (context, state) {
      return BottomNavigationBar(
        currentIndex: state.selectedIndex ?? 0,
        unselectedItemColor: textColorAddtional,
        selectedItemColor: primaryColor,
        backgroundColor: backgroundColorAddtional,
        onTap: (index) {
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      );
    },
  );
}
