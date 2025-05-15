# Movie Info App

TMDB API를 기반으로 하는 Flutter 영화 정보 앱입니다.  
다크모드 UI에 최적화되어 있으며, 인기 영화, 평점순, 개봉예정작 등의 정보를 확인할 수 있습니다.

---

## 프로젝트 구조

```plaintext
lib/
├── data/                    # 외부 데이터 통신 (TMDB API) 및 DTO 관리
│   ├── datasources/         # API 요청 인터페이스 및 구현체
│   │   ├── movie_data_source.dart          # 추상 클래스 (인터페이스)
│   │   └── movie_data_source_impl.dart     # 구현체
│   └── dtos/
│       ├── movie_response_dto.dart         # 영화 리스트 응답 DTO
│       └── movie_detail_dto.dart           # 영화 상세 응답 DTO
│
├── models/
│   └── movie.dart                           # 프리젠테이션 계층 Movie 모델
│
├── pages/
│   ├── home_page.dart                       # 홈 화면
│   └── detail_page.dart                     # 상세 화면
│
├── providers/
│   └── movie_provider.dart                  # ViewModel (상태관리)
│
├── services/
│   └── movie_api_service.dart               # HTTP API 유틸
│
├── theme/
│   └── dark_theme.dart                      # 다크 테마 설정
│
├── utils/
│   └── constants.dart                       # API URL 등 상수 관리
│
├── widgets/
│   ├── movie_section.dart                   # 섹션 UI
│   └── movie_image_card.dart                # 카드 UI
│
└── main.dart                                # 앱 시작점
```

---
# 기술 스택
Flutter (3.x 이상)

Provider (상태관리)

TMDB API

flutter_dotenv (API 키 보안 관리)
