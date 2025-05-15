// lib/data/dto/movie_response_dto.dart

class MovieResponseDto {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final double voteAverage;

  MovieResponseDto({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.voteAverage,
  });

  factory MovieResponseDto.fromJson(Map<String, dynamic> json) {
    return MovieResponseDto(
      id: json['id'] ?? 0,
      title: json['title'] ?? '제목 없음',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
    );
  }
}
