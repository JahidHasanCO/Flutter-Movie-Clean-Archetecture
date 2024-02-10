import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/resources/data_state.dart';
import '../../../domain/usecases/get_popular_movies_usecase.dart';
import 'popular_movies_remote_event.dart';
import 'popular_movies_remote_state.dart';

class PopularMoviesRemoteBloc
    extends Bloc<PopularMoviesRemoteEvent, PopularMoviesRemoteState> {
  final GetPopularMoviesUseCase getPopularMoviesUseCase;

  PopularMoviesRemoteBloc(
    this.getPopularMoviesUseCase,
  ) : super(const PopularMoviesRemoteLoadingState()) {
    on<GetPopularMoviesEvent>(onGetPopularMovies);
  }

  Future<void> onGetPopularMovies(GetPopularMoviesEvent event,
      Emitter<PopularMoviesRemoteState> emitter) async {
    final dataState = await getPopularMoviesUseCase();

    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emitter(PopularMoviesRemoteLoadedState(dataState.data!));
    }

    if (dataState is DataError) {
      emitter(PopularMoviesRemoteErrorState(dataState.error!));
    }
  }
}
