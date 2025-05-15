import 'package:movie_info_app/data/dto/movie_detail_dto.dart';
import 'package:movie_info_app/data/dto/movie_response_dto.dart';

abstract class MovieDataSource {
  Future<MovieResponseDto> getNowPlayingMovies();  // 현재 상영중인 영화
  Future<MovieResponseDto> getPopularMovies();    // 인기 영화
  Future<MovieResponseDto> getTopRatedMovies();   // 평점 높은 영화
  Future<MovieResponseDto> getUpcomingMovies();   // 개봉 예정 영화
  Future<MovieDetailDto> getMovieDetail(int movieId);  // 영화 상세 정보
}
