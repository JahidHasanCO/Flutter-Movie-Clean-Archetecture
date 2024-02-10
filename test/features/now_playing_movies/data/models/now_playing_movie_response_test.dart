import 'dart:convert';

import 'package:flutter_demo_app/features/now_playing_movies/data/models/now_playing_movie_response.dart';
import 'package:flutter_demo_app/features/now_playing_movies/domain/entities/now_playing_movies_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helpers/json_reader.dart';

void main() {
  final results = NowPlayingMovieResult(
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

  final nowPlayingMovieResposne = NowPlayingMovieResponse(
      page: 1, results: [results], totalPages: 100, totalResults: 100);

  test('should be a subclass of NowPlayingMoviesEntity', () {
    expect(
        nowPlayingMovieResposne.results.first, isA<NowPlayingMoviesEntity>());
  });

  test('should return valid model from json', () async {
    // arrange
    final nowPlayingMovieResponse = NowPlayingMovieResponse(
      page: 1,
      results: [
        NowPlayingMovieResult(
          adult: false,
          backdropPath: "/4MCKNAc6AbWjEsM2h9Xc29owo4z.jpg",
          genreIds: [28, 53, 18],
          id: 866398,
          originalLanguage: "en",
          originalTitle: "The Beekeeper",
          overview:
              "One man’s campaign for vengeance takes on national stakes after he is revealed to be a former operative of a powerful and clandestine organization known as Beekeepers.",
          popularity: 2265.436,
          posterPath: "/A7EByudX0eOzlkQ2FIbogzyazm2.jpg",
          releaseDate: DateTime.parse("2024-01-10"),
          title: "The Beekeeper",
          video: false,
          voteAverage: 7.255,
          voteCount: 894,
        ),
      ],
      totalPages: 42392,
      totalResults: 847834,
    );

    final Map<String, dynamic> jsonMap = json.decode(readJson(
        'test/features/now_playing_movies/helpers/dummy_data/dummy_now_playing_movie_response.json'));

    // act
    final result = NowPlayingMovieResponse.fromJson(jsonMap);

    // expect
    expect(result.toString(), equals(nowPlayingMovieResponse.toString()));
  });

  test('should return a valid json from model', () {
    // arrange
    final Map<String, dynamic> jsonMap = {
      "page": 1,
      "results": [
        {
          "adult": false,
          "backdrop_path": "/test.jpg",
          "genre_ids": [1, 2],
          "id": 1,
          "original_language": "en",
          "original_title": "Test Movie",
          "overview": "Test Overview",
          "popularity": 1.0,
          "poster_path": "/test.jpg",
          "release_date": "2021-01-01",
          "title": "Test Movie",
          "video": false,
          "vote_average": 1.0,
          "vote_count": 1
        }
      ],
      "total_pages": 100,
      "total_results": 100
    };

    // act
    final result = nowPlayingMovieResposne.toJson();

    // expect
    expect(result, equals(jsonMap));
  });
}
