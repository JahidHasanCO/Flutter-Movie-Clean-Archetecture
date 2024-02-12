import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/colors/colors.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'bottom_nav_bar.dart';
import 'now_playing_movies.dart';

class MobileHomeBody extends StatelessWidget {
  const MobileHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      bottomNavigationBar: buildBottomNavigationBar(),
      body: _buildBodyWithBottomNavBarBloc(),
    ));
  }

  _buildBodyWithBottomNavBarBloc() {
    return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
        builder: (context, state) {
      switch (state.selectedEvent) {
        case BottomNavBarEvent.homeSelected:
          return _homePageBody(context);
        case BottomNavBarEvent.searchSelected:
          return Container();
        case BottomNavBarEvent.profileSelected:
          return Container();
        default:
          return Container(); // Placeholder for unknown index
      }
    });
  }

  _homePageBody(context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              buildNowPlayingMovies(
                deviceHeight,
                deviceWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Image(
                  image: const AssetImage('assets/images/netflix.png'),
                  height: (deviceWidth * 0.08),
                  width: (deviceWidth * 0.08),
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.05),
            child: Text(
              'Popular Movies',
              textAlign: TextAlign.start,
              style: TextStyle(
                  fontSize: (deviceWidth * 0.04),
                  fontWeight: FontWeight.bold,
                  color: textColor),
            ),
          ),
        ],
      ),
    );
  }
}
