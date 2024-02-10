import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/now_playing_movies_repository.dart';
import '../data_sources/remote/now_playing_movie_api_service.dart';
import '../../../common/data/models/movie_response.dart';

class NowPlayingMoviesRepositoryImpl extends NowPlayingMoviesRepository {
  final NowPlayingMovieApiService _nowPlayingMovieApiService;

  NowPlayingMoviesRepositoryImpl(this._nowPlayingMovieApiService);

  @override
  Future<DataState<List<MovieResult>>> getNowPlayingMovies() async {
    try {
      final response = await _nowPlayingMovieApiService.getNowPlayingMovies(
          includeAdult: 'true',
          includeVideo: 'true',
          language: 'en-US',
          page: '1',
          sortBy: 'popularity.desc',
          withReleaseType: '2|3',
          releaseDateGte: '{min_date}',
          releaseDateLte: '{max_date}');

      if (response.response.statusCode == HttpStatus.ok) {
        final nowPlayingMovies =
            MovieResponse.fromJson(response.response.data).results;

        debugPrint('Now Playing Movies: ${response.response.data}');

        if (nowPlayingMovies.isEmpty) {
          return DataError(DioException(
              error: 'No data found',
              response: response.response,
              type: DioExceptionType.unknown,
              requestOptions: response.response.requestOptions));
        }
        return DataSuccess(nowPlayingMovies);
      } else {
        return DataError(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions));
      }
    } on DioException catch (e) {
      return DataError(e);
    }
  }
}
