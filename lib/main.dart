import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'data/movie_repository.dart';
import 'ui/catalog_screen.dart';

void main() {
  final binding = WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) binding.ensureSemantics();
  const token = String.fromEnvironment('TMDB_TOKEN');
  const demo = bool.fromEnvironment('DEMO_MODE', defaultValue: true);
  if (!demo && token.trim().isEmpty) {
    runApp(const MoviesApp(configurationError: true));
    return;
  }
  runApp(
    MoviesApp(
      repository: demo ? DemoRepository() : TmdbRepository(token: token),
    ),
  );
}

class MoviesApp extends StatelessWidget {
  const MoviesApp({
    super.key,
    this.repository,
    this.configurationError = false,
  });
  final MovieRepository? repository;
  final bool configurationError;
  @override
  Widget build(BuildContext context) => MaterialApp(
    title: 'Movies • Histórias para descobrir',
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: const Color(0xff10151d),
      colorScheme: ColorScheme.fromSeed(
        seedColor: const Color(0xffe8be79),
        brightness: Brightness.dark,
        primary: const Color(0xffe8be79),
        surface: const Color(0xff19212c),
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 42,
          fontWeight: FontWeight.w700,
          letterSpacing: -1.5,
        ),
        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
        bodyLarge: TextStyle(fontSize: 17, height: 1.65),
        bodyMedium: TextStyle(fontSize: 15, height: 1.5),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),
      ),
    ),
    home: configurationError
        ? const Scaffold(
            body: SafeArea(
              child: Center(
                child: Padding(
                  padding: EdgeInsets.all(32),
                  child: Text(
                    'Configure TMDB_TOKEN para usar a API ou execute com DEMO_MODE=true.',
                  ),
                ),
              ),
            ),
          )
        : CatalogScreen(repository: repository ?? DemoRepository()),
  );
}
