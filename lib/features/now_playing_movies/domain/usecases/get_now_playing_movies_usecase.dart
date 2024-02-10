import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../../../common/domain/entities/movies_entity.dart';
import '../repository/now_playing_movies_repository.dart';

class GetNowPlayingMoviesUseCase
    implements UseCase<DataState<List<MoviesEntity>>, void> {
  final NowPlayingMoviesRepository _nowPlayingMoviesRepository;

  GetNowPlayingMoviesUseCase(this._nowPlayingMoviesRepository);

  @override
  Future<DataState<List<MoviesEntity>>> call({void params}) {
    return _nowPlayingMoviesRepository.getNowPlayingMovies();
  }
}
