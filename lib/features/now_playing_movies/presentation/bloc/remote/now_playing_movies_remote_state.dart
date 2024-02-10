import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_demo_app/features/common/domain/entities/movies_entity.dart';

abstract class NowPlayingMoviesRemoteState extends Equatable {
  final List<MoviesEntity>? movies;
  final DioException? error;

  const NowPlayingMoviesRemoteState({this.movies, this.error});

  @override
  List<Object?> get props => [movies!, error!];
}

class NowPlayingMoviesRemoteLoadingState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteLoadingState();
}

class NowPlayingMoviesRemoteLoadedState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteLoadedState(List<MoviesEntity> movies)
      : super(movies: movies);
}

class NowPlayingMoviesRemoteErrorState extends NowPlayingMoviesRemoteState {
  const NowPlayingMoviesRemoteErrorState(DioException error)
      : super(error: error);
}
