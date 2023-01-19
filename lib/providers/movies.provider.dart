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

  getNowPlayingMovies() async {
    var url = Uri.https(
      _domain,
      '3/movie/now_playing',
      {'api_key': _apiKey, 'language': _language, 'page': '1'},
    );
    var response = await http.get(url);
    NowPlayingResponse res =
        NowPlayingResponse.fromMap(jsonDecode(response.body));
    onDisplayMovies = res.results;
    notifyListeners();
  }

  getPopularMovies() async {
    var url = Uri.https(
      _domain,
      '3/movie/popular',
      {'api_key': _apiKey, 'language': _language, 'page': '1'},
    );
    var response = await http.get(url);
    PopularMoviesResponse res =
        PopularMoviesResponse.fromMap(jsonDecode(response.body));
    popularMovies = res.results;
    notifyListeners();
  }
}
