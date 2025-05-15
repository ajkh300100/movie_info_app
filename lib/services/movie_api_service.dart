import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import '../models/movie.dart';

class MovieApiService {
  static const String _baseUrl = 'https://api.themoviedb.org/3';

  final String? _token = dotenv.env['TMDB_V4_ACCESS_TOKEN'];

  Map<String, String> get _headers {
    if (_token == null || _token.isEmpty) {
      throw Exception('TMDB V4 Access Token이 설정되지 않았습니다. .env 파일을 확인하세요.');
    }
    return {
      'Authorization': 'Bearer $_token',  // Bearer 형식으로 토큰 전달
      'Content-Type': 'application/json;charset=utf-8',
    };
  }

  Future<List<Movie>> fetchNowPlaying() async {
    final uri = Uri.parse('$_baseUrl/movie/now_playing?language=ko-KR&page=1');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List results = body['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('현재 상영 중인 영화를 가져오는 데 실패했습니다. (${response.statusCode}): ${response.body}');
    }
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final uri = Uri.parse('$_baseUrl/movie/popular?language=ko-KR&page=1');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List results = body['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('인기 영화를 가져오는 데 실패했습니다. (${response.statusCode}): ${response.body}');
    }
  }

  Future<List<Movie>> fetchTopRated() async {
    final uri = Uri.parse('$_baseUrl/movie/top_rated?language=ko-KR&page=1');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List results = body['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('평점 높은 영화를 가져오는 데 실패했습니다. (${response.statusCode}): ${response.body}');
    }
  }

  Future<List<Movie>> fetchUpcoming() async {
    final uri = Uri.parse('$_baseUrl/movie/upcoming?language=ko-KR&page=1');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      final List results = body['results'];
      return results.map((e) => Movie.fromJson(e)).toList();
    } else {
      throw Exception('개봉 예정 영화를 가져오는 데 실패했습니다. (${response.statusCode}): ${response.body}');
    }
  }

  // 영화 상세 정보 가져오기
  Future<Movie> fetchMovieDetails(int movieId) async {
    final uri = Uri.parse('$_baseUrl/movie/$movieId?language=ko-KR');
    final response = await http.get(uri, headers: _headers);

    if (response.statusCode == 200) {
      final body = json.decode(response.body);
      return Movie.fromJson(body);
    } else {
      throw Exception('영화 상세 정보를 가져오는 데 실패했습니다. (${response.statusCode}): ${response.body}');
    }
  }
}
