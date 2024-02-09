import '../../../../core/resources/data_state.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/now_playing_movies_entity.dart';
import '../repository/now_playing_movies_repository.dart';

class GetNowPlayingMoviesUseCase
    implements UseCase<DataState<List<NowPlayingMoviesEntity>>, void> {
  final NowPlayingMoviesRepository _nowPlayingMoviesRepository;

  GetNowPlayingMoviesUseCase(this._nowPlayingMoviesRepository);

  @override
  Future<DataState<List<NowPlayingMoviesEntity>>> call({void params}) {
    return _nowPlayingMoviesRepository.getNowPlayingMovies();
  }
}
