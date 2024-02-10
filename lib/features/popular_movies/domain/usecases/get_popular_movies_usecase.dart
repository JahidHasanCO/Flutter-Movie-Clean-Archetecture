import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../common/domain/entities/movies_entity.dart';
import '../repository/popular_movies_repository.dart';

class GetPopularMoviesUseCase
    implements UseCase<DataState<List<MoviesEntity>>, void> {
  final PopularMoviesRepository _popularMoviesRepository;

  GetPopularMoviesUseCase(this._popularMoviesRepository);

  @override
  Future<DataState<List<MoviesEntity>>> call({void params}) {
    return _popularMoviesRepository.getPopularMovies();
  }
}
