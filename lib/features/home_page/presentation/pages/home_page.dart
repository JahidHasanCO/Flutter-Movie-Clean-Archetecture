import 'package:flutter/material.dart';
import 'package:flutter_demo_app/features/common/presentation/responsive/responsive.dart';
import 'package:flutter_demo_app/injection_container.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import '../bloc/bottom_nav_bar/bottom_nav_bar_state.dart';
import '../widgets/now_playing_movies.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../now_playing_movies/presentation/widget/movie_card.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_state.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var deviceHeight = MediaQuery.of(context).size.height;
    var deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }
}

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
// import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_state.dart';

// import '../../../now_playing_movies/presentation/widget/movie_card.dart';
// import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
// import '../../../popular_movies/presentation/bloc/remote/popular_movies_remote_state.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});
//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int selectedIndex = 0;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: _buildAppBar(),
//       body: Row(
//         children: [
//           if (MediaQuery.of(context).size.width >= 640)
//             NavigationRail(
//                 useIndicator: false,
//                 elevation: 1,
//                 selectedIconTheme:
//                     const IconThemeData(color: Colors.indigoAccent, size: 30),
//                 unselectedIconTheme:
//                     const IconThemeData(color: Colors.grey, size: 30),
//                 selectedLabelTextStyle:
//                     const TextStyle(color: Colors.indigoAccent),
//                 unselectedLabelTextStyle: const TextStyle(color: Colors.grey),
//                 extended: false,
//                 onDestinationSelected: (int index) {
//                   setState(() {
//                     selectedIndex = index;
//                   });
//                 },
//                 destinations: const [
//                   NavigationRailDestination(
//                     icon: Icon(Icons.home),
//                     label: Text('Home'),
//                   ),
//                   NavigationRailDestination(
//                     icon: Icon(Icons.search),
//                     label: Text('Search'),
//                   ),
//                   NavigationRailDestination(
//                     icon: Icon(Icons.person),
//                     label: Text('Profile'),
//                   ),
//                 ],
//                 selectedIndex: selectedIndex),
//           Expanded(
//             child: _buildBody(),
//           ),
//         ],
//       ),
//       bottomNavigationBar: MediaQuery.of(context).size.width < 640
//           ? _buildBottomNavigationBar()
//           : null,
//     );
//   }

//   _buildBody() {
//     switch (selectedIndex) {
//       case 0:
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 16),
//             _buildNowPlayingMovieOnTop(),
//             const SizedBox(height: 16),
//             const Text('Popular Movies', style: TextStyle(fontSize: 24)),
//             _buildPopularMovies(),
//           ],
//         );
//       case 1:
//         return Container();
//       case 2:
//         return Container();
//       default:
//         return Container(); // Placeholder for unknown index
//     }
//   }

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

// _buildBottomNavigationBar() {
//   return BottomNavigationBar(
//     currentIndex: selectedIndex,
//     unselectedItemColor: Colors.grey,
//     selectedItemColor: Colors.indigoAccent,
//     onTap: (index) {
//       setState(() {
//         selectedIndex = index;
//       });
//     },
//     items: const <BottomNavigationBarItem>[
//       BottomNavigationBarItem(
//         icon: Icon(Icons.home),
//         label: 'Home',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.search),
//         label: 'Search',
//       ),
//       BottomNavigationBarItem(
//         icon: Icon(Icons.person),
//         label: 'Profile',
//       ),
//     ],
//   );
// }

_buildBottomNavigationBar() {
  return BlocBuilder<BottomNavBarBloc, BottomNavBarState>(
    builder: (context, state) {
      return BottomNavigationBar(
        currentIndex: state.selectedIndex ?? 0,
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.indigoAccent,
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
