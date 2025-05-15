import 'package:flutter/material.dart';
import 'package:movie_info_app/models/movie.dart';
import 'package:movie_info_app/services/movie_api_service.dart';

class MovieProvider extends ChangeNotifier {
  List<Movie> nowPlaying = [];
  List<Movie> popular   = [];
  List<Movie> topRated  = [];
  List<Movie> upcoming  = [];

  final MovieApiService _apiService = MovieApiService();

  MovieProvider() {
    fetchAllMovies();
  }

  Future<void> fetchAllMovies() async {
    try {
      nowPlaying = await _apiService.fetchNowPlaying();
      popular    = await _apiService.fetchPopularMovies();
      topRated   = await _apiService.fetchTopRated();
      upcoming   = await _apiService.fetchUpcoming();
      notifyListeners();
    } catch (e) {
      // 에러 로깅 추가 (필요시 UI에서도 처리 가능)
      print('영화 목록을 불러오는 중 오류 발생: $e');
    }
  }

  List<Movie> get nowPlayingMovies => nowPlaying;
  List<Movie> get popularMovies     => popular;
  List<Movie> get topRatedMovies    => topRated;
  List<Movie> get upcomingMovies    => upcoming;
}
