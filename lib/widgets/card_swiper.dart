import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapp/models/models.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  final List<Movie> movies;

  const CardSwiper({
    super.key,
    required this.movies,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height * 0.5,
      child: Swiper(
        itemCount: movies.length,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        layout: SwiperLayout.STACK,
        itemBuilder: (_, index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () =>
                Navigator.pushNamed(context, 'details', arguments: 'peli-q'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                image: NetworkImage(movie.fullPosterPath),
                placeholder: const AssetImage('assets/no-image.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
