import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/colors/colors.dart';
import '../../../../core/util/image_poster_url.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
import '../../../now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_state.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import 'side_navigation_bar.dart';

class DesktopHomeBody extends StatelessWidget {
  const DesktopHomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: buildSideNavigationBar(buildBodyWithSideNavBarBloc()),
      ),
    );
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

  _homePageBody(context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            alignment: Alignment.topLeft,
            children: [
              _buildNowPlayingMoviesSlider(
                deviceHeight,
                deviceWidth,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image(
                      image: const AssetImage('assets/images/netflix.png'),
                      height: (deviceHeight * 0.05),
                      width: (deviceWidth * 0.05),
                      fit: BoxFit.contain,
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: (deviceHeight * 0.03)),
                      child: Container(
                        height: (deviceHeight * 0.05),
                        width: (deviceHeight * 0.05),
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                              fit: BoxFit.contain,
                              image: AssetImage('assets/images/avater.png')),
                          borderRadius: BorderRadius.all(Radius.circular(100)),
                          color: Colors.redAccent,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: deviceWidth * 0.03),
            child: const Text(
              'Popular Movies',
              style: TextStyle(
                  fontSize: 24, fontWeight: FontWeight.bold, color: textColor),
            ),
          ),
        ],
      ),
    );
  }

  _buildNowPlayingMoviesSlider(deviceHeight, deviceWidth) {
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
                  height: deviceHeight * 0.9,
                  scrollPhysics: const AlwaysScrollableScrollPhysics(),
                  viewportFraction: 1,
                  autoPlay: true,
                  enableInfiniteScroll: true,
                  autoPlayInterval: const Duration(seconds: 4)),
              items: state.movies!.map((movie) {
                return Stack(
                  children: [
                    SizedBox(
                      height: deviceHeight * 0.9,
                      width: deviceWidth,
                      child: CachedNetworkImage(
                        imageUrl: posterUrlMake(movie.backdropPath ?? ""),
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
                              width: deviceWidth * 0.078,
                              height: deviceHeight * 0.05,
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
                                    fontSize: deviceWidth * 0.01,
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
                                  label: const Text('More Info'),
                                  icon: const Icon(Icons.arrow_forward_ios),
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
}
