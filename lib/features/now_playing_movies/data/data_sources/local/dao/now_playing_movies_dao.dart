import 'package:floor/floor.dart';
import 'package:flutter_demo_app/features/common/data/models/movie_response.dart';
import '../../../../../common/utils/movie_type.dart';

@dao
abstract class NowPlayingMoviesDao {
  @Query('SELECT * FROM movies WHERE movieType = :movieType')
  Future<List<MovieResult>> getAllNowPlayingMovies(MovieType movieType);

  @insert
  Future<void> insertNowPlayingMovies(MovieResult nowPlayingMovies);

  @insert
  Future<void> insertAllNowPlayingMovies(List<MovieResult> nowPlayingMovies);

  @delete
  Future<void> deleteNowPlayingMovies(MovieResult nowPlayingMovies);

  @Query('DELETE FROM movies')
  Future<void> deleteAllNowPlayingMovies();
}
