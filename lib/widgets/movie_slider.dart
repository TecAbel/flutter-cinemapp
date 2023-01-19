import 'package:cinemapp/models/models.dart';
import 'package:cinemapp/providers/movies.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSlider extends StatelessWidget {
  final List<Movie> movies;
  const MovieSlider({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int initialPage = 1;
    final movieProvider = Provider.of<MoviesProvider>(context);
    ScrollController _controller = ScrollController();
    if (movies.isEmpty) {
      return SizedBox(
        height: size.height * 0.37,
        width: double.infinity,
        child: const Center(child: CircularProgressIndicator()),
      );
    }
    _controller.addListener(() {
      double last = _controller.position.maxScrollExtent;
      double current = _controller.position.pixels;
      if (current + 100 >= last) {
        movieProvider.getPopularMovies(page: initialPage += 1);
      }
    });
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.37,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(left: 20, top: 10),
            child: Text('Populares',
                style: TextStyle(fontWeight: FontWeight.bold)),
          ),
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              controller: _controller,
              itemCount: movies.length,
              itemBuilder: (context, index) => _MoviePoster(
                movie: movies[index],
              ),
            ),
          )
        ],
      ),
    );
  }
}

class _MoviePoster extends StatelessWidget {
  final Movie movie;
  const _MoviePoster({
    Key? key,
    required this.movie,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190,
      width: 130,
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Column(children: [
        GestureDetector(
          onTap: () =>
              Navigator.pushNamed(context, 'details', arguments: 'la peli'),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              image: NetworkImage(movie.fullPosterPath),
              placeholder: const AssetImage('assets/no-image.jpg'),
              height: 170,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 5),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: Text(
              movie.title,
              textAlign: TextAlign.center,
              maxLines: 2,
              style: const TextStyle(overflow: TextOverflow.ellipsis),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ]),
    );
  }
}
