import 'package:flutter_demo_app/features/now_playing_movies/presentation/bloc/remote/now_playing_movies_remote_bloc.dart';

import '../data/data_sources/remote/now_playing_movie_api_service.dart';
import '../data/repository/now_playing_movies_repository_impl.dart';
import '../domain/repository/now_playing_movies_repository.dart';
import '../domain/usecases/get_now_playing_movies_usecase.dart';
import '../../../injection_container.dart';

void nowPlayingMoviesDIContainer() {
  locator.registerSingleton<NowPlayingMovieApiService>(
      NowPlayingMovieApiService(locator()));

  locator.registerSingleton<NowPlayingMoviesRepository>(
      NowPlayingMoviesRepositoryImpl(locator(), locator()));

  locator.registerSingleton<GetNowPlayingMoviesUseCase>(
      GetNowPlayingMoviesUseCase(locator()));

  locator.registerFactory<NowPlayingMoviesRemoteBloc>(
      () => NowPlayingMoviesRemoteBloc(locator()));
}
