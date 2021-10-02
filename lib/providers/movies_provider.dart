//import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:movie_slider/models/credits_response.dart';
import 'package:movie_slider/models/movie.dart';
import 'package:movie_slider/models/now_playing_response.dart';
import 'package:movie_slider/models/popular_response.dart';

class MoviesProvider extends ChangeNotifier {
  String _apiKey = '4fed43b49267eb86e1d12b26245c8c29';
  String _baseUrl =
      'api.themoviedb.org'; //no hace falta poner el https:// porque esta definido en el Uri.https
  String _language = 'en-US';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];
  Map<int, List<Cast>> moviesCast = {};
  int _popularPage = 0;

  MoviesProvider() {
    print('MoviesProvider Inicializado');
    this.getOnDisplayMovies();
    this.getOnDisplayMovies();
  }

  Future<String> _getJsonData(String enpoint, [int page = 1]) async {
    var url = Uri.https(_baseUrl, enpoint,
        {'api_key': _apiKey, 'language': _language, 'page': '$page'});
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await _getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    onDisplayMovies = nowPlayingResponse.results;
    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    final jsonData = await _getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    // old code final Map<String, dynamic> decodedData = json.decode(response.body);
    popularMovies = [...popularMovies, ...popularResponse.results];
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async {
    if (moviesCast.containsKey(movieId)) return moviesCast[movieId]!;
    final jsonData = await _getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    moviesCast[movieId] = creditsResponse.cast;
    return creditsResponse.cast;
  }
}
