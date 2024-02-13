import 'dart:io';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo_app/core/resources/app_database.dart';
import 'package:flutter_demo_app/features/common/domain/entities/movies_entity.dart';
import 'package:flutter_demo_app/features/common/utils/movie_type.dart';
import '../../../../core/resources/data_state.dart';
import '../../domain/repository/now_playing_movies_repository.dart';
import '../data_sources/remote/now_playing_movie_api_service.dart';
import '../../../common/data/models/movie_response.dart';

class NowPlayingMoviesRepositoryImpl extends NowPlayingMoviesRepository {
  final NowPlayingMovieApiService _nowPlayingMovieApiService;

  final AppDatabase _appDatabase;

  NowPlayingMoviesRepositoryImpl(
      this._nowPlayingMovieApiService, this._appDatabase);

  @override
  Future<DataState<List<MovieResult>>> getNowPlayingMovies() async {
    try {
      final connectivityResult = await (Connectivity().checkConnectivity());

      if (connectivityResult == ConnectivityResult.none) {
        final localNowPlayingMovies = await getLocalNowPlayingMovies();

        if (localNowPlayingMovies.isEmpty) {
          return DataError(DioException(
            error: 'No local data found',
            response: Response(requestOptions: RequestOptions(path: '')),
            type: DioExceptionType.unknown,
            requestOptions: RequestOptions(path: ''),
          ));
        }

        return DataSuccess(localNowPlayingMovies);
      } else {
        final response = await _nowPlayingMovieApiService.getNowPlayingMovies(
          includeAdult: 'true',
          includeVideo: 'true',
          language: 'en-US',
          page: '1',
          sortBy: 'popularity.desc',
          withReleaseType: '2|3',
          releaseDateGte: '{min_date}',
          releaseDateLte: '{max_date}',
        );

        if (response.response.statusCode == HttpStatus.ok) {
          final nowPlayingMovies =
              MovieResponse.fromJson(response.response.data).results;

          if (nowPlayingMovies.isEmpty) {
            return DataError(DioException(
              error: 'No data found',
              response: response.response,
              type: DioExceptionType.unknown,
              requestOptions: response.response.requestOptions,
            ));
          }
          await deleteAllCachedNowPlayingMovies();
          await cacheNowPlayingMovies(nowPlayingMovies);
          return DataSuccess(nowPlayingMovies);
        } else {
          return DataError(DioException(
            error: response.response.statusMessage,
            response: response.response,
            type: DioExceptionType.badResponse,
            requestOptions: response.response.requestOptions,
          ));
        }
      }
    } on DioException catch (e) {
      return DataError(e);
    } on Exception catch (e) {
      return DataError(DioException(
        error: 'An unexpected error occurred: $e',
        response: Response(requestOptions: RequestOptions(path: '')),
        type: DioExceptionType.unknown,
        requestOptions: RequestOptions(path: ''),
      ));
    }
  }

  @override
  Future<void> cacheNowPlayingMovies(List<MoviesEntity> movies) async {
    return await _appDatabase.nowPlayingMoviesDao.insertAllNowPlayingMovies(
        movies.map((e) => MovieResult.fromEntity(e)).toList());
  }

  @override
  Future<void> deleteAllCachedNowPlayingMovies() async {
    return await _appDatabase.nowPlayingMoviesDao.deleteAllNowPlayingMovies();
  }

  @override
  Future<void> deleteNowPlayingMovies(MoviesEntity movie) async {
    return await _appDatabase.nowPlayingMoviesDao
        .deleteNowPlayingMovies(MovieResult.fromEntity(movie));
  }

  @override
  Future<List<MovieResult>> getLocalNowPlayingMovies() async {
    List<MovieResult> localData = await _appDatabase.nowPlayingMoviesDao
        .getAllNowPlayingMovies(MovieType.nowPlaying);

    if (localData.isNotEmpty) {
      return localData;
    } else {
      return [];
    }
  }
}
