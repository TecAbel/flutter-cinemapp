import 'package:cinemapp/models/models.dart';

class PopularMoviesResponse {
  PopularMoviesResponse({
    required this.page,
    required this.results,
    required this.totalPages,
    required this.totalResults,
  });

  int page;
  List<Movie> results;
  int totalPages;
  int totalResults;

  PopularMoviesResponse.fromMap(Map<String, dynamic> json)
      : page = json['page'],
        totalResults = json['total_results'],
        totalPages = json['total_pages'],
        results =
            List<Movie>.from(json['results'].map((i) => Movie.fromMap(i)));
}
