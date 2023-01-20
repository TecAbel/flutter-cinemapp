import 'package:cinemapp/models/models.dart';
import 'package:cinemapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Movie movie = ModalRoute.of(context)?.settings.arguments as Movie;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _CustomAppBar(
            title: movie.title,
            urlImage: movie.fullBackDropPath,
          ),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterHead(movie: movie),
                _PosterBody(
                  str: movie.overview,
                ),
                const _PosterBody(),
                const _PosterBody(),
                const _PosterBody(),
                const CastSlider(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class _PosterBody extends StatelessWidget {
  final String? str;
  const _PosterBody({Key? key, this.str}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          str ??
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet accumsan tellus, nec consequat justo. Nullam risus lacus, tempus quis venenatis et, feugiat in lacus. Curabitur nec euismod massa.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}

class _CustomAppBar extends StatelessWidget {
  final String? title;
  final String? urlImage;
  const _CustomAppBar({
    Key? key,
    required this.title,
    required this.urlImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(bottom: 15),
          color: const Color.fromRGBO(0, 0, 0, 0.4),
          alignment: Alignment.bottomCenter,
          child: Text(title ?? 'movie.title'),
        ),
        centerTitle: true,
        background: FadeInImage(
          placeholder: const AssetImage('assets/loading.gif'),
          image: NetworkImage(urlImage ?? 'https://via.placeholder/500x300'),
          fit: BoxFit.cover,
          alignment: Alignment.center,
        ),
      ),
    );
  }
}

class _PosterHead extends StatelessWidget {
  final Movie movie;
  const _PosterHead({required this.movie});
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeInImage(
            height: 180,
            placeholder: const AssetImage('assets/no-image.jpg'),
            image: NetworkImage(movie.fullPosterPath),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 160,
              child: Text(
                movie.title,
                style: textTheme.titleLarge,
                maxLines: 5,
              ),
            ),
            SizedBox(
              width: 160,
              child: Text(
                movie.originalTitle,
                style: textTheme.subtitle1,
              ),
            ),
            Row(
              children: [
                const Icon(
                  Icons.star_border,
                  size: 16,
                  color: Colors.grey,
                ),
                const SizedBox(width: 10),
                Text(
                  '${movie.voteAverage}',
                  style: textTheme.caption,
                )
              ],
            )
          ],
        ),
      ]),
    );
  }
}
