import 'package:flutter/material.dart';
import 'package:movie_slider/providers/movies_provider.dart';
import 'package:provider/provider.dart';

import 'screens/screens.dart';

void main() => runApp(AppState());

class AppState extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              MoviesProvider(), //El guin bajo quiere decir BuildContext context
          lazy: false,
        ),
      ],
      child: MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      title: 'Movie Slider',
      initialRoute: 'home',
      routes: {
        'home': (_) => HomeScrren(),
        'details': (_) => DetailsScrren(),
      },
      //Let's apply this Theme if the system Theme above does not work.
      // theme: ThemeData.light().copyWith(
      //     appBarTheme: AppBarTheme(
      //   color: Colors.indigo,
      // )),
    );
  }
}
