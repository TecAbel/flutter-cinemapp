import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

class CardSwiper extends StatelessWidget {
  const CardSwiper({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      width: double.infinity,
      height: size.height / 2,
      child: Swiper(
        itemCount: 10,
        itemWidth: size.width * 0.6,
        itemHeight: size.height * 0.4,
        layout: SwiperLayout.STACK,
        itemBuilder: (_, index) => ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: const FadeInImage(
            image: NetworkImage('https://via.placeholder.com/300x400'),
            placeholder: AssetImage('assets/no-image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
