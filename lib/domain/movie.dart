/// Immutable values parsed once at the external-data boundary.
class Movie {
  const Movie._({
    required this.id,
    required this.title,
    required this.overview,
    required this.rating,
    this.releaseDate,
    this.posterPath,
    this.posterAsset,
    this.runtime,
    required this.genres,
    required this.language,
    required this.tagline,
  });
  final int id;
  final String title, overview, language, tagline;
  final double rating;
  final DateTime? releaseDate;
  final String? posterPath, posterAsset;
  final int? runtime;
  final List<String> genres;
  String? get posterUrl =>
      posterPath == null ? null : 'https://image.tmdb.org/t/p/w500$posterPath';
  String get year => releaseDate?.year.toString() ?? 'Sem data';

  factory Movie.fromJson(Map<String, dynamic> json) => Movie._parse(json);

  /// Only trusted local fixtures may select a bundled poster.
  factory Movie.fromDemoJson(Map<String, dynamic> json) =>
      Movie._parse(json, demo: true);

  static Movie _parse(Map<String, dynamic> json, {bool demo = false}) {
    final asset = demo ? json['poster_asset'] : null;
    if (asset != null &&
        (asset is! String ||
            !RegExp(r'^assets/posters/[a-z0-9-]+\.svg$').hasMatch(asset))) {
      throw const FormatException('Invalid bundled poster');
    }
    final id = json['id'];
    final title = json['title'];
    final rating = json['vote_average'] ?? 0;
    if (id is! int ||
        id <= 0 ||
        title is! String ||
        title.trim().isEmpty ||
        rating is! num ||
        !rating.isFinite ||
        rating < 0 ||
        rating > 10) {
      throw const FormatException('Invalid movie identity or rating');
    }
    final path = json['poster_path'];
    if (path != null &&
        (path is! String || !RegExp(r'^/[a-zA-Z0-9_.-]+$').hasMatch(path))) {
      throw const FormatException('Invalid poster path');
    }
    final date = optionalText(json, 'release_date');
    final parsedDate = date.isEmpty ? null : DateTime.tryParse(date);
    if (date.isNotEmpty &&
        (parsedDate == null ||
            parsedDate.toIso8601String().substring(0, 10) != date)) {
      throw const FormatException('Invalid release date');
    }
    final runtime = json['runtime'];
    if (runtime != null && (runtime is! int || runtime < 0)) {
      throw const FormatException('Invalid runtime');
    }
    final rawGenres = json['genres'] ?? <dynamic>[];
    if (rawGenres is! List) throw const FormatException('Invalid genres');
    final genres = rawGenres
        .map((item) => optionalText(objectJson(item), 'name'))
        .toList();
    return Movie._(
      id: id,
      title: title.trim(),
      overview: optionalText(json, 'overview'),
      rating: rating.toDouble(),
      posterPath: path as String?,
      posterAsset: asset as String?,
      releaseDate: parsedDate,
      runtime: runtime as int?,
      genres: List.unmodifiable(genres),
      language: optionalText(json, 'original_language'),
      tagline: optionalText(json, 'tagline'),
    );
  }
}

Map<String, dynamic> objectJson(Object? value) {
  if (value is! Map<String, dynamic>) {
    throw const FormatException('Expected JSON object');
  }
  return value;
}

String optionalText(Map<String, dynamic> json, String key) {
  final value = json[key];
  if (value == null) return '';
  if (value is! String) throw FormatException('Invalid $key');
  return value;
}

class MoviePage {
  MoviePage({
    required this.page,
    required this.totalPages,
    required List<Movie> movies,
  }) : movies = List.unmodifiable(movies);
  final int page, totalPages;
  final List<Movie> movies;
  factory MoviePage.fromJson(Object? data) {
    final json = objectJson(data);
    final page = json['page'];
    final total = json['total_pages'];
    final results = json['results'];
    if (page is! int ||
        page < 1 ||
        page > 500 ||
        total is! int ||
        total < 0 ||
        results is! List ||
        (total > 0 && page > total) ||
        (total == 0 && results.isNotEmpty)) {
      throw const FormatException('Invalid pagination');
    }
    return MoviePage(
      page: page,
      totalPages: total > 500 ? 500 : total,
      movies: results.map((item) => Movie.fromJson(objectJson(item))).toList(),
    );
  }
}
