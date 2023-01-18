import 'package:cinemapp/widgets/widgets.dart';
import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final String movie =
        ModalRoute.of(context)?.settings.arguments.toString() ?? 'no-movie';
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          const _CustomAppBar(),
          SliverList(
            delegate: SliverChildListDelegate(
              [
                _PosterHead(),
                const _PosterBody(),
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
  const _PosterBody({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nam sit amet accumsan tellus, nec consequat justo. Nullam risus lacus, tempus quis venenatis et, feugiat in lacus. Curabitur nec euismod massa.',
          textAlign: TextAlign.justify,
          style: Theme.of(context).textTheme.subtitle1,
        ));
  }
}

class _CustomAppBar extends StatelessWidget {
  const _CustomAppBar({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 200,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.all(0),
        title: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.only(bottom: 15),
          color: const Color.fromRGBO(0, 0, 0, 0.6),
          alignment: Alignment.bottomCenter,
          child: const Text('movie.title'),
        ),
        centerTitle: true,
        background: const FadeInImage(
          placeholder: AssetImage('assets/loading.gif'),
          image: NetworkImage('https://via.placeholder.com/500x300'),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _PosterHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      margin: const EdgeInsets.only(top: 20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            height: 180,
            placeholder: AssetImage('assets/no-image.jpg'),
            image: NetworkImage('https://via.placeholder.com/200x300'),
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'movie.title',
              style: textTheme.titleLarge,
            ),
            Text(
              'movie.resume',
              style: textTheme.subtitle1,
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
                  'movie.likeAverage',
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
