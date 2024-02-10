import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../common/data/models/movie_response.dart';

part 'popular_movie_api_service.g.dart';

@RestApi(baseUrl: tmdbBaseURL)
abstract class PopularMovieApiService {
  factory PopularMovieApiService(Dio dio) = _PopularMovieApiService;

  @GET('/movie/popular')
  Future<HttpResponse<MovieResponse>> getPopularMovies(
      {@Query("api_key") String apiKey = tmdbAPIKey,
      @Query("include_adult") String? includeAdult,
      @Query("include_video") String? includeVideo,
      @Query("language") String? language,
      @Query("page") String? page,
      @Query("sort_by") String? sortBy});
}
