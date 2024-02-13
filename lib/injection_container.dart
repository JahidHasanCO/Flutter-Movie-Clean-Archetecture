import 'package:dio/dio.dart';
import 'package:flutter_demo_app/core/resources/app_database.dart';
import 'package:get_it/get_it.dart';
import 'features/home_page/di/home_page_di_container.dart';
import 'features/now_playing_movies/di/now_playing_movies_di_container.dart';
import 'features/popular_movies/di/popular_movies_di_container.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  locator.registerSingleton<Dio>(Dio());

  nowPlayingMoviesDIContainer();
  popularMoviesDIContainer();

  homePageDIContainer();
}
