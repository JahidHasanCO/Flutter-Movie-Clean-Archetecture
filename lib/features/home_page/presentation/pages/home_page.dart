import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_state.dart';

import '../../../now_playing_movies/presentation/widget/movie_card.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_state.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Row(
        children: [
          if (MediaQuery.of(context).size.width >= 640)
            NavigationRail(
                useIndicator: false,
                elevation: 1,
                selectedIconTheme:
                    const IconThemeData(color: Colors.indigoAccent, size: 30),
                unselectedIconTheme:
                    const IconThemeData(color: Colors.grey, size: 30),
                selectedLabelTextStyle:
                    const TextStyle(color: Colors.indigoAccent),
                unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
                extended: false,
                onDestinationSelected: (int index) {
                  setState(() {
                    selectedIndex = index;
                  });
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
                selectedIndex: selectedIndex),
          Expanded(
            child: _buildBody(),
          ),
        ],
      ),
      bottomNavigationBar: MediaQuery.of(context).size.width < 640
          ? _buildBottomNavigationBar()
          : null,
    );
  }

  _buildAppBar() {
    return AppBar(
      title: const Text('Movie App'),
    );
  }

  _buildBody() {
    switch (selectedIndex) {
      case 0:
        return Column(
          children: [
            _buildNowPlayingMovieOnTop(),
            const Text('Popular Movies', style: TextStyle(fontSize: 24)),
            _buildPopularMovies(),
          ],
        );
      case 1:
        return Container();
      case 2:
        return Container();
      default:
        return Container(); // Placeholder for unknown index
    }
  }

  _buildNowPlayingMovieOnTop() {
    return BlocBuilder<NowPlayingMoviesRemoteBloc, NowPlayingMoviesRemoteState>(
      builder: (_, state) {
        if (state is NowPlayingMoviesRemoteLoadedState) {
          if (state.movies!.isEmpty) {
            return const Center(
              child: Text('No movies available'),
            );
          } else {
            return Expanded(
              child: ListView.builder(
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
        if (state is NowPlayingMoviesRemoteErrorState) {
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

  _buildBottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: selectedIndex,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.indigoAccent,
      onTap: (index) {
        setState(() {
          selectedIndex = index;
        });
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
  }
}
