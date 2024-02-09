import '../../../../core/resources/data_state.dart';
import '../entities/now_playing_movies_entity.dart';

abstract class NowPlayingMoviesRepository {
  Future<DataState<List<NowPlayingMoviesEntity>>> getNowPlayingMovies();
}
