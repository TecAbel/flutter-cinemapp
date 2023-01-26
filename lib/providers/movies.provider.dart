import 'dart:async';
import 'dart:convert';

import 'package:cinemapp/helpers/debouncer.dart';
import 'package:cinemapp/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final _domain = 'api.themoviedb.org';
  final _apiKey = '654a945b0b97249c03dd8dfdbc008c0f';
  final _language = 'es-MX';

  final debouncer = Debouncer(duration: const Duration(milliseconds: 500));
  final StreamController<SearchResponse> _suggestionsStreamController =
      StreamController.broadcast();

  Stream<SearchResponse> get suggestionStream =>
      _suggestionsStreamController.stream;

  int popularPage = 0;

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, MovieCreditsResponse> castListed = {};

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<Map<String, dynamic>> _getMoviesRequest(String endpoint,
      {int page = 1, String? query}) async {
    var url = Uri.https(
      _domain,
      endpoint,
      {
        'api_key': _apiKey,
        'language': _language,
        'page': '$page',
        'query': query,
      },
    );
    var response = await http.get(url);
    return jsonDecode(response.body);
  }

  getNowPlayingMovies() async {
    NowPlayingResponse res = NowPlayingResponse.fromMap(
        await _getMoviesRequest('3/movie/now_playing'));
    onDisplayMovies = res.results;
    notifyListeners();
  }

  getPopularMovies({int page = 1}) async {
    popularPage += 1;
    PopularMoviesResponse res = PopularMoviesResponse.fromMap(
        await _getMoviesRequest('3/movie/popular', page: popularPage));
    popularMovies = [...popularMovies, ...res.results];
    notifyListeners();
  }

  Future<MovieCreditsResponse> getMovieCredits(int movieId) async {
    if (castListed.containsKey(movieId)) {
      return castListed[movieId]!;
    }
    var res = await _getMoviesRequest('3/movie/$movieId/credits');
    castListed[movieId] = MovieCreditsResponse.fromJson(res);
    return castListed[movieId]!;
  }

  Future<SearchResponse> getSearchResults(String query) async {
    var res = await _getMoviesRequest('3/search/movie', query: query);
    return SearchResponse.fromJson(res);
  }

  void getSuggestionsByQuery(String query) {
    debouncer.value = '';
    debouncer.onValue = (value) async {
      final res = await getSearchResults(value);
      _suggestionsStreamController.add(res);
    };

    final timer = Timer.periodic(const Duration(milliseconds: 300), (_) {
      debouncer.value = query;
    });

    Future.delayed(const Duration(milliseconds: 301))
        .then((_) => timer.cancel());
  }
}
