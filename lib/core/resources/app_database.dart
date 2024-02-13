import 'package:floor/floor.dart';
import 'package:flutter_demo_app/features/common/data/models/movie_response.dart';
import 'package:flutter_demo_app/features/now_playing_movies/data/data_sources/local/dao/now_playing_movies_dao.dart';
import '../../features/common/utils/converter/floor_date_time_converter.dart';
import '../../features/common/utils/converter/floor_list_int_converter.dart';
import '../../features/common/utils/movie_type.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import 'dart:async';
part 'app_database.g.dart';

@Database(version: 1, entities: [MovieResult])
abstract class AppDatabase extends FloorDatabase {
  NowPlayingMoviesDao get nowPlayingMoviesDao;
}
