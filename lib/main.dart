import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // dotenv 패키지 import
import 'package:provider/provider.dart'; // provider 패키지 import
import 'pages/home_page.dart'; // 홈 페이지를 import
import 'providers/movie_provider.dart'; // MovieProvider import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Flutter 초기화 보장
  await dotenv.load(fileName: '.env'); // .env 파일을 로드하여 환경변수 로드
  runApp(const MyApp()); // 앱 실행
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MovieProvider()), // MovieProvider 등록
      ],
      child: MaterialApp(
        title: 'Movie Info App', // 앱 제목 설정
        theme: ThemeData.dark(), // 어두운 테마 설정
        home: const HomePage(), // 홈 페이지로 이동
      ),
    );
  }
}
