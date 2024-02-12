import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_demo_app/config/colors/colors.dart';
import 'package:flutter_demo_app/features/common/presentation/responsive/responsive.dart';
import '../../../../core/util/image_poster_url.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_state.dart';

dynamic buildNowPlayingMovies(deviceHeight, deviceWidth) {
  return BlocBuilder<NowPlayingMoviesRemoteBloc, NowPlayingMoviesRemoteState>(
    builder: (context, state) {
      if (state is NowPlayingMoviesRemoteLoadedState) {
        if (state.movies!.isEmpty) {
          return const Center(
            child: Text('No movies available'),
          );
        } else {
          return CarouselSlider(
            options: CarouselOptions(
                height:
                    isMobile(context) ? deviceHeight * 0.5 : deviceHeight * 0.9,
                scrollPhysics: const AlwaysScrollableScrollPhysics(),
                viewportFraction: 1,
                autoPlay: true,
                enableInfiniteScroll: true,
                autoPlayInterval: const Duration(seconds: 4)),
            items: state.movies!.map((movie) {
              return Stack(
                children: [
                  SizedBox(
                    height: isMobile(context)
                        ? deviceHeight * 0.5
                        : deviceHeight * 0.9,
                    width: deviceWidth,
                    child: CachedNetworkImage(
                      imageUrl: isMobile(context)
                          ? posterUrlMake(movie.posterPath ?? "")
                          : posterUrlMake(movie.backdropPath ?? ""),
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    width: deviceWidth,
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          backgroundColor,
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: deviceWidth * 0.03,
                    left: 0,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.03, vertical: 5),
                          child: Container(
                            width: isMobile(context)
                                ? deviceWidth * 0.06
                                : deviceWidth * 0.078,
                            height: isMobile(context)
                                ? deviceWidth * 0.03
                                : deviceWidth * 0.02,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  100), // Adjust the radius as needed
                              color: Colors.white.withOpacity(
                                  0.1), // Adjust the opacity and color as needed
                            ),
                            child: Center(
                              child: Text(
                                'Now Playing',
                                style: TextStyle(
                                  color: textColor,
                                  fontSize: isMobile(context)
                                      ? deviceWidth * 0.05
                                      : deviceWidth * 0.01,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.03, vertical: 5),
                          child: Text(
                            movie.title ?? '',
                            style: TextStyle(
                              fontSize: deviceWidth * 0.06,
                              color: textColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: deviceWidth * 0.5,
                          child: Padding(
                            padding: EdgeInsets.only(
                              left: deviceWidth * 0.03,
                            ),
                            child: Text(movie.overview ?? '',
                                style: TextStyle(
                                  fontSize: deviceWidth * 0.009,
                                  color: textColorAddtional,
                                )),
                          ),
                        ),
                        SizedBox(
                          height: deviceHeight * 0.02,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: deviceWidth * 0.03, vertical: 5),
                          child: Row(
                            children: [
                              ElevatedButton.icon(
                                label: const Text('Watch Movie'),
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.white,
                                  foregroundColor: backgroundColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.03,
                                      vertical: deviceWidth * 0.013),
                                  textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: deviceWidth * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: deviceWidth * 0.01,
                              ),
                              ElevatedButton.icon(
                                label: const Text('Watch Movie'),
                                icon: const Icon(Icons.play_arrow),
                                onPressed: () {},
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: textColor,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: deviceWidth * 0.03,
                                      vertical: deviceWidth * 0.013),
                                  textStyle: TextStyle(
                                    color: textColor,
                                    fontSize: deviceWidth * 0.01,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  side: const BorderSide(color: textColor),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
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
