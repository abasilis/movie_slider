import 'package:flutter/material.dart';
import 'package:movie_slider/providers/movies_provider.dart';
import 'package:movie_slider/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScrren extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
        appBar: AppBar(
          title: Text('Movies in Cinema'),
          elevation: 0,
          centerTitle: true,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search_outlined),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              //Tarjetas de Arriba/Slider
              CardSwiper(movies: moviesProvider.onDisplayMovies),
              //Slider de abajo.
              MovieSlider(
                movies: moviesProvider.popularMovies,
                title: 'Now playing',
                onNextPage: () => moviesProvider.getPopularMovies(),
              ),
            ],
          ),
        ));
  }
}
