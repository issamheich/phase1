abstract class Media {
  final bool adult;
  final String backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<String> genreNames;

  Media({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.genreNames,
  });

  // Abstract getter for title
  String get title;

  @override
  String toString() {
    return 'Media(id: $id, title: $title, overview: $overview, popularity: $popularity)';
  }
}
