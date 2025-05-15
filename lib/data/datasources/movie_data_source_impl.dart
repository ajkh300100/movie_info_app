import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movie_info_app/data/datasources/movie_data_source.dart';
import 'package:movie_info_app/data/dto/movie_detail_dto.dart';
import 'package:movie_info_app/data/dto/movie_response_dto.dart';
import 'package:movie_info_app/utils/constants.dart';  // constants.dart를 import

class MovieDataSourceImpl implements MovieDataSource {
  final http.Client client;

  MovieDataSourceImpl(this.client);

  @override
  Future<MovieResponseDto> getNowPlayingMovies() async {
    try {
      final response = await client.get(Uri.parse('${Constants.baseUrl}/movie/now_playing?api_key=${Constants.apiKey}'));
      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load now playing movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getPopularMovies() async {
    try {
      final response = await client.get(Uri.parse('${Constants.baseUrl}/movie/popular?api_key=${Constants.apiKey}'));
      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load popular movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getTopRatedMovies() async {
    try {
      final response = await client.get(Uri.parse('${Constants.baseUrl}/movie/top_rated?api_key=${Constants.apiKey}'));
      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load top-rated movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieResponseDto> getUpcomingMovies() async {
    try {
      final response = await client.get(Uri.parse('${Constants.baseUrl}/movie/upcoming?api_key=${Constants.apiKey}'));
      if (response.statusCode == 200) {
        return MovieResponseDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load upcoming movies');
      }
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<MovieDetailDto> getMovieDetail(int movieId) async {
    try {
      final response = await client.get(Uri.parse('${Constants.baseUrl}/movie/$movieId?api_key=${Constants.apiKey}'));
      if (response.statusCode == 200) {
        return MovieDetailDto.fromJson(json.decode(response.body));
      } else {
        throw Exception('Failed to load movie details');
      }
    } catch (e) {
      rethrow;
    }
  }
}
