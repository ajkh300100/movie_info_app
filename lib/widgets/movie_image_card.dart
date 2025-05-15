import 'package:flutter/material.dart';
import 'package:movie_info_app/models/movie.dart';
import 'package:movie_info_app/pages/detail_page.dart';

class MovieImageCard extends StatelessWidget {
  final Movie movie; // Movie 객체를 받음

  const MovieImageCard({super.key, required this.movie}); // movie 매개변수 추가

  @override
  Widget build(BuildContext context) {
    final imageBaseUrl = 'https://image.tmdb.org/t/p/w500';

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailPage(movieId: movie.id), // movieId를 DetailPage로 전달
          ),
        );
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          '$imageBaseUrl${movie.posterPath}',
          height: 250,
          width: double.infinity,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, progress) {
            if (progress == null) return child;
            return SizedBox(
              height: 250,
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
            return SizedBox(
              height: 250,
              child: Center(
                child: Icon(Icons.broken_image, size: 64, color: Colors.grey),
              ),
            );
          },
        ),
      ),
    );
  }
}
