// lib/utils/constants.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Constants {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? 'https://api.themoviedb.org/3';
  static String get apiKey => dotenv.env['API_KEY'] ?? 'your_default_api_key_here';
}
