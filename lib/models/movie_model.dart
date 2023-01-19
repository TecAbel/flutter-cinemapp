class Movie {
  Movie({
    required this.adult,
    this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    this.releaseDate,
    required this.title,
    required this.video,
    this.voteAverage,
    required this.voteCount,
  });

  bool adult;
  String? backdropPath;
  List<int> genreIds;
  int id;
  String originalLanguage;
  String originalTitle;
  String overview;
  double popularity;
  String posterPath;
  DateTime? releaseDate;
  String title;
  bool video;
  double? voteAverage;
  int voteCount;

  get fullPosterPath {
    return 'https://image.tmdb.org/t/p/w500$posterPath';
  }

  Movie.fromMap(Map<String, dynamic> json)
      : adult = json['adult'],
        backdropPath = json['backdrop_path'],
        genreIds = List<int>.from(json['genre_ids'].map((i) => i)),
        id = json['id'],
        originalLanguage = json['original_language'],
        originalTitle = json['original_title'],
        overview = json['overview'],
        popularity = json['popularity'],
        posterPath = json['poster_path'],
        releaseDate = DateTime.parse(json['release_date']),
        title = json['title'],
        video = json['video'],
        voteAverage = json['vote'],
        voteCount = json['vote_count'];
}
