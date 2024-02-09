import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'features/now_playing_movies/di/now_playing_movies_di_container.dart';

final locator = GetIt.instance;

Future<void> initializeDependencies() async {
  locator.registerSingleton<Dio>(Dio());

  nowPlayingMoviesDIContainer();
}
