import 'package:cinemapp/models/models.dart';

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
