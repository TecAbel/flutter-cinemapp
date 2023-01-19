import 'dart:convert';

import 'package:cinemapp/models/now_playing_response.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MoviesProvider extends ChangeNotifier {
  final domain = 'api.themoviedb.org';
  final apiKey = '654a945b0b97249c03dd8dfdbc008c0f';
  final language = 'es-MX';

  MoviesProvider() {
    print('movies init');
    this.getNowPlayingMovies();
  }

  getNowPlayingMovies() async {
    var url = Uri.https(
      domain,
      '3/movie/now_playing',
      {'api_key': apiKey, 'language': language, 'page': '1'},
    );
    var response = await http.get(url);
    NowPlayingResponse res =
        NowPlayingResponse.fromMap(jsonDecode(response.body));
    print(res.results[0].title);
  }
}
