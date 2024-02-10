import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../../../core/util/image_poster_url.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_state.dart';

dynamic buildNowPlayingMovies(deviceHeight, deviceWidth) {
  return BlocBuilder<NowPlayingMoviesRemoteBloc, NowPlayingMoviesRemoteState>(
    builder: (_, state) {
      if (state is NowPlayingMoviesRemoteLoadedState) {
        if (state.movies!.isEmpty) {
          return const Center(
            child: Text('No movies available'),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
                height: deviceHeight * 0.70,
                viewportFraction: 0.9,
                autoPlay: false,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 2)),
            items: state.movies!.map((movie) {
              return Stack(
                children: [
                  Container(
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(
                          posterUrlMake(movie.backdropPath ?? ''),
                        ),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Container(
                    width: deviceWidth,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: deviceWidth * 0.05, vertical: 10),
                      child: Text(movie.title ?? '',
                          style: TextStyle(
                              fontSize: deviceWidth * 0.06,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              );
            }).toList(),
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
