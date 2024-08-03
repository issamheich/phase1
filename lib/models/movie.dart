import '/models/media.dart';

class Movie extends Media {
  final String originalTitle;
  final String releaseDate;
  final bool video;
  final double voteAverage;
  final int voteCount;

  Movie({
    required bool adult,
    required String backdropPath,
    required List<int> genreIds,
    required int id,
    required String originalLanguage,
    required this.originalTitle,
    required this.releaseDate,
    required String title,
    required String overview,
    required double popularity,
    required String posterPath,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
    required List<String> genreNames,
  }) : super(
          adult: adult,
          backdropPath: backdropPath,
          genreIds: genreIds,
          id: id,
          originalLanguage: originalLanguage,
          overview: overview,
          popularity: popularity,
          posterPath: posterPath,
          genreNames: genreNames,
        );

  @override
  String get title => originalTitle;

  factory Movie.fromJson(
      Map<String, dynamic> json, Map<int, String> genreMapping) {
    return Movie(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalTitle: json['original_title'],
      releaseDate: json['release_date'],
      title: json['original_title'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      video: json['video'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      genreNames: List<String>.from(
          json['genre_ids'].map((id) => genreMapping[id] ?? 'Unknown')),
    );
  }
}
