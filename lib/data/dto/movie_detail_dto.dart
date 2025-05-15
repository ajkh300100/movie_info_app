class MovieDetailDto {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final String tagline;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final int budget;
  final int revenue;
  final List<ProductionCompanyDto> productionCompanies;

  MovieDetailDto({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    required this.budget,
    required this.revenue,
    required this.productionCompanies,
  });

  factory MovieDetailDto.fromJson(Map<String, dynamic> json) {
    return MovieDetailDto(
      id: json['id'] ?? 0,
      title: json['title'] ?? '제목 없음',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      tagline: json['tagline'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
      budget: json['budget'] ?? 0,
      revenue: json['revenue'] ?? 0,
      productionCompanies: (json['production_companies'] as List<dynamic>? ?? [])
          .map((e) => ProductionCompanyDto.fromJson(e))
          .toList(),
    );
  }
}

class ProductionCompanyDto {
  final int id;
  final String name;
  final String logoPath;

  ProductionCompanyDto({
    required this.id,
    required this.name,
    required this.logoPath,
  });

  factory ProductionCompanyDto.fromJson(Map<String, dynamic> json) {
    return ProductionCompanyDto(
      id: json['id'] ?? 0,
      name: json['name'] ?? '이름 없음',
      logoPath: json['logo_path'] ?? '',
    );
  }
}
