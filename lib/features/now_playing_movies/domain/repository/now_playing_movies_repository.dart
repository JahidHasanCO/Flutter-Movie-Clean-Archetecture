import '../../../../core/resources/data_state.dart';
import '../../../common/domain/entities/movies_entity.dart';

abstract class NowPlayingMoviesRepository {
  Future<DataState<List<MoviesEntity>>> getNowPlayingMovies();

  Future<List<MoviesEntity>> getLocalNowPlayingMovies();

  Future<void> cacheNowPlayingMovies(List<MoviesEntity> movies);

  Future<void> deleteNowPlayingMovies(MoviesEntity movie);

  Future<void> deleteAllCachedNowPlayingMovies();
}
