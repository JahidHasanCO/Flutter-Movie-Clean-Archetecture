import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/config/theme/app_themes.dart';
import 'package:flutter_demo_app/features/home_page/presentation/bloc/bottom_nav_bar/bottom_nav_bar_bloc.dart';
import 'package:flutter_demo_app/features/home_page/presentation/pages/home_page.dart';
import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';
import 'package:flutter_demo_app/features/popular_movies/presentation/bloc/remote/popular_movies_remote_bloc.dart';
import 'package:flutter_demo_app/features/popular_movies/presentation/bloc/remote/popular_movies_remote_event.dart';
import 'features/common/presentation/providers/bloc_providers.dart';
import 'features/home_page/presentation/bloc/bottom_nav_bar/bottom_nav_bar_event.dart';
import 'features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_event.dart';
import 'injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.dark,
      theme: lightTheme(),
      darkTheme: darkTheme(),
      home: MultiBlocProvider(
        providers: [
          buildRemoteBlocProvider(
            bloc: NowPlayingMoviesRemoteBloc(locator()),
            event: const GetNowPlayingMoviesEvent(),
          ),
          buildRemoteBlocProvider(
            bloc: PopularMoviesRemoteBloc(locator()),
            event: const GetPopularMoviesEvent(),
          ),
          buildRemoteBlocProvider(
            bloc: BottomNavBarBloc(),
            event: BottomNavBarEvent.homeSelected,
          ),
        ],
        child: const HomePage(),
      ),
    );
  }
}
