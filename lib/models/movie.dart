class Movie {
  final int id;
  final String title;
  final String posterPath;
  final String releaseDate;
  final String overview;
  final String tagline;
  final double voteAverage;
  final int voteCount;
  final double popularity;
  final int? budget;
  final int? revenue;
  final List<ProductionCompany> productionCompanies;

  Movie({
    required this.id,
    required this.title,
    required this.posterPath,
    required this.releaseDate,
    required this.overview,
    required this.tagline,
    required this.voteAverage,
    required this.voteCount,
    required this.popularity,
    this.budget,
    this.revenue,
    required this.productionCompanies,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    var companies = json['production_companies'] as List? ?? [];
    List<ProductionCompany> productionCompanies = companies
        .map((companyJson) => ProductionCompany.fromJson(companyJson))
        .toList();

    return Movie(
      id: json['id'] ?? 0,
      title: json['title'] ?? '제목 없음',
      posterPath: json['poster_path'] ?? '',
      releaseDate: json['release_date'] ?? '',
      overview: json['overview'] ?? '',
      tagline: json['tagline'] ?? '',
      voteAverage: (json['vote_average'] ?? 0).toDouble(),
      voteCount: json['vote_count'] ?? 0,
      popularity: (json['popularity'] ?? 0).toDouble(),
      budget: json['budget'],
      revenue: json['revenue'],
      productionCompanies: productionCompanies,
    );
  }
}

class ProductionCompany {
  final int id;
  final String name;
  final String logoPath;

  ProductionCompany({
    required this.id,
    required this.name,
    required this.logoPath,
  });

  factory ProductionCompany.fromJson(Map<String, dynamic> json) {
    return ProductionCompany(
      id: json['id'] ?? 0,
      name: json['name'] ?? '이름 없음',
      logoPath: json['logo_path'] ?? '',
    );
  }
}
