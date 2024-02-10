import '../../../../core/resources/data_state.dart';
import '../../../common/domain/entities/movies_entity.dart';

abstract class NowPlayingMoviesRepository {
  Future<DataState<List<MoviesEntity>>> getNowPlayingMovies();
}
