import 'package:flutter_demo_app/features/common/data/models/movie_response.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:flutter_demo_app/core/constants/constants.dart';
part 'now_playing_movie_api_service.g.dart';

@RestApi(baseUrl: tmdbBaseURL)
abstract class NowPlayingMovieApiService {
  factory NowPlayingMovieApiService(Dio dio) = _NowPlayingMovieApiService;

  @GET('/movie/now_playing')
  Future<HttpResponse<MovieResponse>> getNowPlayingMovies({
    @Query("api_key") String apiKey = tmdbAPIKey,
    @Query("include_adult") String? includeAdult,
    @Query("include_video") String? includeVideo,
    @Query("language") String? language,
    @Query("page") String? page,
    @Query("sort_by") String? sortBy,
    @Query("with_release_type") String? withReleaseType,
    @Query("release_date.gte") String? releaseDateGte,
    @Query("release_date.lte") String? releaseDateLte,
  });
}
