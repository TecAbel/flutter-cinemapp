import 'package:cinemapp/models/movie_model.dart';
import 'package:cinemapp/providers/movies.provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MovieSearch extends SearchDelegate {
  @override
  String? get searchFieldLabel => 'Buscar película';

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return const Text('results');
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);
    if (query.isEmpty) {
      return _emptySearch();
    }

    moviesProvider.getSuggestionsByQuery(query);

    return StreamBuilder(
      stream: moviesProvider.suggestionStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return _emptySearch();
        }

        var movies = snapshot.data!.results;

        return ListView.builder(
          itemCount: movies.length,
          itemBuilder: (context, index) => _MovieItem(movie: movies[index]),
        );
      },
    );
  }
}

class _MovieItem extends StatelessWidget {
  const _MovieItem({
    Key? key,
    required this.movie,
  }) : super(key: key);

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    movie.heroId = 'from-search-${movie.id}';
    return ListTile(
      title: Text(movie.title),
      subtitle: Text(movie.originalTitle),
      onTap: () {
        Navigator.pushNamed(context, 'details', arguments: movie);
      },
      leading: Hero(
        tag: movie.heroId!,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(5),
          child: FadeInImage(
            placeholder: const AssetImage('assets/no-image.jpg'),
            width: 40,
            image: NetworkImage(movie.fullPosterPath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

Widget _emptySearch() {
  return Center(
      child: Icon(
    Icons.movie_creation_outlined,
    size: 100,
    color: Colors.grey[400],
  ));
}
