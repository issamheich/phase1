import '/models/media.dart';

class TVShow extends Media {
  final String originalName;
  final String firstAirDate;
  final double voteAverage;
  final int voteCount;
  final String posterPath;

  TVShow({
    required bool adult,
    required String backdropPath,
    required List<int> genreIds,
    required int id,
    required String originalLanguage,
    required this.originalName,
    required this.firstAirDate,
    required String overview,
    required double popularity,
    required this.voteAverage,
    required this.voteCount,
    required List<String> genreNames,
    required this.posterPath,
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
  String get title => originalName;

  factory TVShow.fromJson(
      Map<String, dynamic> json, Map<int, String> genreMapping) {
    return TVShow(
      adult: json['adult'],
      backdropPath: json['backdrop_path'],
      genreIds: List<int>.from(json['genre_ids']),
      id: json['id'],
      originalLanguage: json['original_language'],
      originalName: json['original_name'],
      firstAirDate: json['first_air_date'],
      overview: json['overview'],
      popularity: json['popularity'].toDouble(),
      posterPath: json['poster_path'],
      voteAverage: json['vote_average'].toDouble(),
      voteCount: json['vote_count'],
      genreNames: List<String>.from(
          json['genre_ids'].map((id) => genreMapping[id] ?? 'Unknown')),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'type': 'tvshow',
      'id': id,
      'title': title,
      'poster_path': posterPath,
    };
  }
}
