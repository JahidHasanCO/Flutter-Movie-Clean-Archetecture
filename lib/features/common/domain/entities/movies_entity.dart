import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import '../../utils/converter/floor_date_time_converter.dart';
import '../../utils/converter/floor_list_int_converter.dart';

class MoviesEntity extends Equatable {
  final bool? adult;
  final String? backdropPath;

  @TypeConverters([ListIntConverter])
  final List<int>? genreIds;
  final int? id;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;

  @TypeConverters([DateTimeConverter])
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;

  const MoviesEntity(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount});

  @override
  List<Object?> get props {
    return [
      adult,
      backdropPath,
      genreIds,
      id,
      originalLanguage,
      originalTitle,
      overview,
      popularity,
      posterPath,
      releaseDate,
      title,
      video,
      voteAverage,
      voteCount
    ];
  }
}
