import 'dart:convert';

import 'package:cinemapp/models/models.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final _domain = 'api.themoviedb.org';
  final _apiKey = '654a945b0b97249c03dd8dfdbc008c0f';
  final _language = 'es-MX';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  MoviesProvider() {
    getNowPlayingMovies();
    getPopularMovies();
  }

  Future<Map<String, dynamic>> _getMoviesRequest(String endpoint,
      {int page = 1}) async {
    var url = Uri.https(
      _domain,
      endpoint,
      {'api_key': _apiKey, 'language': _language, 'page': page.toString()},
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
    PopularMoviesResponse res = PopularMoviesResponse.fromMap(
        await _getMoviesRequest('3/movie/popular', page: page));
    popularMovies = [...popularMovies, ...res.results];
    notifyListeners();
  }
}
