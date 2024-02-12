import 'package:flutter/material.dart';
import '../../../common/presentation/responsive/responsive_layout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../now_playing_movies/presentation/widget/movie_card.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_state.dart';
import '../widgets/desktop_home_body.dart';
import '../widgets/mobile_home_body.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(
        mobileBody: MobileHomeBody(),
        tabletBody: DesktopHomeBody(),
        desktopBody: DesktopHomeBody());
  }
}

_buildPopularMovies() {
  return BlocBuilder<PopularMoviesRemoteBloc, PopularMoviesRemoteState>(
    builder: (_, state) {
      if (state is PopularMoviesRemoteLoadedState) {
        if (state.movies!.isEmpty) {
          return const Center(
            child: Text(
              'No movies available',
            ),
          );
        } else {
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return MovieCard(
                movie: state.movies![index],
              );
            },
            itemCount: state.movies!.length,
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
