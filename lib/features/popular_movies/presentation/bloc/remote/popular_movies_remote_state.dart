import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import '../../../../common/domain/entities/movies_entity.dart';

abstract class PopularMoviesRemoteState extends Equatable {
  final List<MoviesEntity>? movies;
  final DioException? error;

  const PopularMoviesRemoteState({this.movies, this.error});

  @override
  List<Object?> get props => [movies!, error!];
}

class PopularMoviesRemoteLoadingState extends PopularMoviesRemoteState {
  const PopularMoviesRemoteLoadingState();
}

class PopularMoviesRemoteLoadedState extends PopularMoviesRemoteState {
  const PopularMoviesRemoteLoadedState(List<MoviesEntity> movies)
      : super(movies: movies);
}

class PopularMoviesRemoteErrorState extends PopularMoviesRemoteState {
  const PopularMoviesRemoteErrorState(DioException error) : super(error: error);
}
