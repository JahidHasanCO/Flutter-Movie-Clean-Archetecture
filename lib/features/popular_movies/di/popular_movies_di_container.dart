import 'package:flutter_demo_app/features/popular_movies/data/data_sources/remote/popular_movie_api_service.dart';
import 'package:flutter_demo_app/injection_container.dart';
import '../data/repository/popular_movies_repository_impl.dart';
import '../domain/repository/popular_movies_repository.dart';
import '../domain/usecases/get_popular_movies_usecase.dart';
import '../presentation/bloc/remote/popular_movies_remote_bloc.dart';

void popularMoviesDIContainer() {
  locator.registerSingleton<PopularMovieApiService>(
      PopularMovieApiService(locator()));

  locator.registerSingleton<PopularMoviesRepository>(
      PopularMoviesRepositoryImpl(locator()));

  locator.registerSingleton<GetPopularMoviesUseCase>(
      GetPopularMoviesUseCase(locator()));

  locator.registerFactory<PopularMoviesRemoteBloc>(
      () => PopularMoviesRemoteBloc(locator()));
}
