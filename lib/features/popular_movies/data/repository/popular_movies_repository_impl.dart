import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_demo_app/core/resources/data_state.dart';
import 'package:flutter_demo_app/features/common/domain/entities/movies_entity.dart';
import 'package:flutter_demo_app/features/popular_movies/data/data_sources/remote/popular_movie_api_service.dart';
import 'package:flutter_demo_app/features/popular_movies/domain/repository/popular_movies_repository.dart';

import '../../../common/data/models/movie_response.dart';

class PopularMoviesRepositoryImpl extends PopularMoviesRepository {
  final PopularMovieApiService _popularMovieApiService;

  PopularMoviesRepositoryImpl(this._popularMovieApiService);

  @override
  Future<DataState<List<MoviesEntity>>> getPopularMovies() async {
    try {
      final response = await _popularMovieApiService.getPopularMovies(
        includeAdult: 'true',
        includeVideo: 'true',
        language: 'en-US',
        page: '1',
        sortBy: 'popularity.desc',
      );

      if (response.response.statusCode == HttpStatus.ok) {
        final popularMovies =
            MovieResponse.fromJson(response.response.data).results;

        debugPrint('popularMovies: $popularMovies');

        if (popularMovies.isEmpty) {
          return DataError(DioException(
              error: 'No data found',
              response: response.response,
              type: DioExceptionType.unknown,
              requestOptions: response.response.requestOptions));
        }
        return DataSuccess(popularMovies);
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
