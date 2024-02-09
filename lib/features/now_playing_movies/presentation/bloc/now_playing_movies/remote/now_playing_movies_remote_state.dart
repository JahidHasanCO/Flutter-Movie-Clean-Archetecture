import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_demo_app/features/now_playing_movies/domain/entities/now_playing_movies_entity.dart';

abstract class NowPlayingMoviesRemoteState extends Equatable {
  final List<NowPlayingMoviesEntity>? movies;
  final DioException? error;

  const NowPlayingMoviesRemoteState({this.movies, this.error});

  @override
  List<Object?> get props => [movies!, error!];
}

class NowPlayingMoviesRemoteLoadingState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteLoadingState();
}

class NowPlayingMoviesRemoteLoadedState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteLoadedState(List<NowPlayingMoviesEntity> movies)
      : super(movies: movies);
}

class NowPlayingMoviesRemoteErrorState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteErrorState(DioException error)
      : super(error: error);
}
