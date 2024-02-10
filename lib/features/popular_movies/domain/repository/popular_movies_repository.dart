import '../../../../core/resources/data_state.dart';
import '../../../common/domain/entities/movies_entity.dart';

abstract class PopularMoviesRepository {
  Future<DataState<List<MoviesEntity>>> getPopularMovies();
}
