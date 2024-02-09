import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_demo_app/features/now_playing_movies/domain/usecases/get_now_playing_movies_usecase.dart';
import '../../../../../../core/resources/data_state.dart';
import 'now_playing_movies_remote_event.dart';
import 'now_playing_movies_remote_state.dart';

class NowPlayingMoviesRemoteBloc
    extends Bloc<NowPlayingMoviesRemoteEvent, NowPlayingMoviesRemoteState> {
  final GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;

  NowPlayingMoviesRemoteBloc(
    this.getNowPlayingMoviesUseCase,
  ) : super(const NowPlayingMoviesRemoteLoadingState()) {
    on<GetNowPlayingMoviesEvent>(onGetNowPlayingMovies);
  }

  Future<void> onGetNowPlayingMovies(GetNowPlayingMoviesEvent event,
      Emitter<NowPlayingMoviesRemoteState> emitter) async {
    final dataState = await getNowPlayingMoviesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emitter(NowPlayingMoviesRemoteLoadedState(dataState.data!));
    }

    if (dataState is DataError) {
      emitter(NowPlayingMoviesRemoteErrorState(dataState.error!));
    }
  }
}
