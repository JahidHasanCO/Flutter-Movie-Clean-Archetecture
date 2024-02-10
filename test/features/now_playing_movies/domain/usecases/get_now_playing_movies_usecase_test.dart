import 'package:flutter_demo_app/core/resources/data_state.dart';
import 'package:flutter_demo_app/features/common/domain/entities/movies_entity.dart';
import 'package:flutter_demo_app/features/now_playing_movies/domain/usecases/get_now_playing_movies_usecase.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/now_playing_movies_repository_helpers.mocks.dart';

void main() {
  late GetNowPlayingMoviesUseCase getNowPlayingMoviesUseCase;
  late MockNowPlayingMoviesRepository mockNowPlayingMoviesRepository;

  setUp(() {
    mockNowPlayingMoviesRepository = MockNowPlayingMoviesRepository();
    getNowPlayingMoviesUseCase =
        GetNowPlayingMoviesUseCase(mockNowPlayingMoviesRepository);
  });

  final testMovieDetails = MoviesEntity(
    adult: false,
    backdropPath: '/test.jpg',
    genreIds: const [1, 2],
    id: 1,
    originalLanguage: 'en',
    originalTitle: 'Test Movie',
    overview: 'Test Overview',
    popularity: 1.0,
    posterPath: '/test.jpg',
    releaseDate: DateTime(2021, 1, 1),
    title: 'Test Movie',
    video: false,
    voteAverage: 1.0,
    voteCount: 1,
  );

  test('should get now playing movies from the repository', () async {
    // arrange
    when(mockNowPlayingMoviesRepository.getNowPlayingMovies())
        .thenAnswer((_) async => DataSuccess([testMovieDetails]));
    // act
    final result = await getNowPlayingMoviesUseCase.call();
    // assert
    expect(result.data, [testMovieDetails]);
  });
}
