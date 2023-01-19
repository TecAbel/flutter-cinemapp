class NowPlayingResponse {
  NowPlayingResponse({
    required this.dates,
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  Dates dates;
  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  NowPlayingResponse.fromMap(Map<String, dynamic> json)
      : dates = Dates.fromMap(json['dates']),
        page = json['page'],
        results =
            List<Movie>.from(json['results'].map((m) => Movie.fromMap(m))),
        totalPages = json['total_pages'],
        totalResults = json['total_results'];
}

// TODO: understand how-to use json_annotation json serialization and deserealization
// @JsonSerializable()
class Dates {
  Dates({
    required this.maximum,
    required this.minimum,
  });

  Dates.fromMap(Map<String, dynamic> json)
      : maximum = DateTime.parse(json['maximum']),
        minimum = DateTime.parse(json['minimum']);

  DateTime maximum;
  DateTime minimum;
}

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
    required this.releaseDate,
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
  DateTime releaseDate;
  String title;
  bool video;
  double? voteAverage;
  int voteCount;

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
