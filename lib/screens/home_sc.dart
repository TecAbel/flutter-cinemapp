import 'package:cinemapp/providers/movies.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MoviesProvider>(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Center(child: Text('Películas en cine')),
        actions: [
          IconButton(
            icon: const Icon(Icons.search_rounded),
            onPressed: () {},
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardSwiper(
              movies: movieProvider.onDisplayMovies,
            ),
            MovieSlider(
              title: 'Populares',
              movies: movieProvider.popularMovies,
              callBackNext: movieProvider.getPopularMovies,
            ),
          ],
        ),
      ),
    );
  }
}
