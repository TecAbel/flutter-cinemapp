import 'package:cinemapp/models/cast_model.dart';
import 'package:cinemapp/models/credits_response.dart';
import 'package:cinemapp/providers/movies.provider.dart';
import 'package:flutter/cupertino.dart';

class CastSlider extends StatelessWidget {
  final int movieId;

  const CastSlider({super.key, required this.movieId});

  @override
  Widget build(BuildContext context) {
    final moviesProvider = MoviesProvider();

    return FutureBuilder(
      future: moviesProvider.getMovieCredits(movieId),
      builder:
          (BuildContext context, AsyncSnapshot<MovieCreditsResponse> snapshot) {
        if (snapshot.hasData) {
          var cast = snapshot.data?.cast ?? [];
          return Container(
            height: 180,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            width: double.infinity,
            child: ListView.builder(
              itemCount: cast.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (ctx, item) => _CastCard(actor: cast[item]),
            ),
          );
        }
        return Container(
          height: 180,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          width: double.infinity,
          child: const CupertinoActivityIndicator(),
        );
      },
    );
  }
}

/* class _CastSliderState extends State<CastSlider> {
  List<Cast> cast = [];
  void getCast() async {
    MoviesProvider movieService = MoviesProvider();
    var res = await movieService.getMovieCredits(widget.movieId);
    cast = res.cast;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCast();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 180,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      width: double.infinity,
      child: ListView.builder(
        itemCount: cast.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (ctx, item) => _CastCard(actor: cast[item]),
      ),
    );
  }
} */

class _CastCard extends StatelessWidget {
  final Cast actor;
  const _CastCard({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: FadeInImage(
              height: 140,
              placeholder: const AssetImage('assets/no-image.jpg'),
              image: NetworkImage(actor.fullPath),
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 5),
          SizedBox(
            width: 70,
            child: Text(
              actor.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }
}
