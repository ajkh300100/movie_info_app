import 'package:flutter/material.dart';
import 'package:movie_info_app/providers/movie_provider.dart';
import 'package:movie_info_app/widgets/movie_section.dart';
import 'package:provider/provider.dart';
import 'package:movie_info_app/pages/detail_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final movieProvider = Provider.of<MovieProvider>(context);
    const imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: ListView(
          children: [
            const SizedBox(height: 16),
            if (movieProvider.popularMovies.isEmpty)
              const Center(child: CircularProgressIndicator())
            else
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      '가장 인기있는 영화',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(
                              movieId: movieProvider.popularMovies[0].id,
                            ),
                          ),
                        );
                      },
                      child: Hero(
                        tag: 'popular_movie_${movieProvider.popularMovies[0].id}',
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.network(
                            '$imageBaseUrl${movieProvider.popularMovies[0].posterPath}',
                            height: 600,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, progress) {
                              if (progress == null) return child;
                              return SizedBox(
                                height: 600,
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value: progress.expectedTotalBytes != null
                                        ? progress.cumulativeBytesLoaded /
                                            (progress.expectedTotalBytes!)
                                        : null,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stack) {
                              return const SizedBox(
                                height: 600,
                                child: Center(
                                  child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            const SizedBox(height: 24),
            MovieSection(
              title: '현재 상영중',
              movies: movieProvider.nowPlayingMovies,
            ),
            MovieSection(
              title: '인기순',
              movies: movieProvider.popularMovies,
              showRanking: true,
            ),
            MovieSection(
              title: '평점 높은순',
              movies: movieProvider.topRatedMovies,
            ),
            MovieSection(
              title: '개봉예정',
              movies: movieProvider.upcomingMovies,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
