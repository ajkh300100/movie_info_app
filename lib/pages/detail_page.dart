import 'package:flutter/material.dart';
import 'package:movie_info_app/models/movie.dart';
import 'package:movie_info_app/services/movie_api_service.dart';

class DetailPage extends StatefulWidget {
  final int movieId;

  const DetailPage({super.key, required this.movieId});

  @override
  _DetailPageState createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  late Future<Movie> _movieFuture;

  @override
  void initState() {
    super.initState();
    _movieFuture = MovieApiService().fetchMovieDetails(widget.movieId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: FutureBuilder<Movie>(
          future: _movieFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('오류 발생: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final movie = snapshot.data!;
              const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

              return ListView(
                children: [
                  Stack(
                    children: [
                      // 영화 포스터 이미지
                      Hero(
                        tag: 'popular_movie_${movie.id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            '$imageBaseUrl${movie.posterPath}',
                            height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      // 뒤로가기 버튼
                      Positioned(
                        top: 16,
                        left: 16,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back, color: Colors.white),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      movie.title,
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '개봉일: ${movie.releaseDate}',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // 러닝타임 추가
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '러닝타임: ${movie.runtime ?? '정보 없음'}분',
                      style: const TextStyle(
                        fontSize: 18,
                        color: Colors.white54,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  // 카테고리(장르) 추가
                  if (movie.genres.isNotEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: movie.genres
                            .map((genre) => Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 6),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[800],
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Text(
                                    genre.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 14,
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      movie.tagline,
                      style: const TextStyle(
                        fontSize: 18,
                        fontStyle: FontStyle.italic,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      movie.overview,
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),

                  // 흥행 정보 - 가로 스크롤 가능하도록 수정
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          '흥행 정보',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 8),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              _buildInfoColumn('평점', movie.voteAverage.toString()),
                              const SizedBox(width: 24),
                              _buildInfoColumn('투표수', movie.voteCount.toString()),
                              const SizedBox(width: 24),
                              _buildInfoColumn('인기점수', movie.popularity.toString()),
                              const SizedBox(width: 24),
                              _buildInfoColumn(
                                  '예산',
                                  movie.budget != null
                                      ? '\$${movie.budget}'
                                      : '정보 없음'),
                              const SizedBox(width: 24),
                              _buildInfoColumn(
                                  '수익',
                                  movie.revenue != null
                                      ? '\$${movie.revenue}'
                                      : '정보 없음'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 24),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      '제작사',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 100,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: movie.productionCompanies.length,
                      itemBuilder: (context, index) {
                        final company = movie.productionCompanies[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: Column(
                            children: [
                              company.logoPath.isNotEmpty
                                  ? Image.network(
                                      '$imageBaseUrl${company.logoPath}',
                                      height: 60,
                                      fit: BoxFit.contain,
                                    )
                                  : const Icon(
                                      Icons.business,
                                      color: Colors.white,
                                      size: 60,
                                    ),
                              const SizedBox(height: 8),
                              Text(
                                company.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('영화 정보를 불러올 수 없습니다.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildInfoColumn(String title, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white54,
          ),
        ),
      ],
    );
  }
}
