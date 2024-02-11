import 'package:flutter/material.dart';
import '../../../common/presentation/responsive/responsive.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../now_playing_movies/presentation/widget/movie_card.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_state.dart';
import '../widgets/bottom_nav_bar.dart';
import '../widgets/now_playing_movies.dart';
import '../widgets/side_navigation_bar.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // var deviceHeight = MediaQuery.of(context).size.height;
    // var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar:
          isMobile(context) ? buildBottomNavigationBar() : null,
      body: isMobile(context)
          ? _buildBodyWithBottomNavBarBloc()
          : buildSideNavigationBar(),
    );
  }
}

buildBodyWithSideNavBarBloc() {
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
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 16),
      buildNowPlayingMovies(MediaQuery.of(context).size.height,
          MediaQuery.of(context).size.width),
      const SizedBox(height: 16),
      const Text('Popular Movies', style: TextStyle(fontSize: 24)),
      _buildPopularMovies(),
    ],
  );
}

_buildPopularMovies() {
  return BlocBuilder<PopularMoviesRemoteBloc, PopularMoviesRemoteState>(
    builder: (_, state) {
      if (state is PopularMoviesRemoteLoadedState) {
        if (state.movies!.isEmpty) {
          return const Center(
            child: Text('No movies available'),
          );
        } else {
          return Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                return MovieCard(
                  movie: state.movies![index],
                );
              },
              itemCount: state.movies!.length,
            ),
          );
        }
      }
      if (state is PopularMoviesRemoteErrorState) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.refresh),
              SizedBox(height: 8),
              Text('Error loading movies. Tap to refresh.'),
            ],
          ),
        );
      }
      return const Center(
        child: CupertinoActivityIndicator(),
      );
    },
  );
}
