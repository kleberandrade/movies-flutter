import 'dart:io';

import 'package:material_ui/material_ui.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:movies/main.dart';
import 'package:movies/data/movie_repository.dart';
import 'package:movies/domain/movie.dart';
import 'package:movies/ui/components.dart';

class RecoverableRepository implements MovieRepository {
  bool fail = true;
  final demo = fixtureRepository();
  @override
  bool get isDemo => true;
  @override
  Future<MoviePage> catalog({int page = 1, String query = ''}) async {
    if (fail) throw const MovieFailure('Sem conexão.');
    return demo.catalog(page: page, query: query);
  }

  @override
  Future<Movie> detail(int id) => demo.detail(id);
}

DemoRepository fixtureRepository() => DemoRepository(
  load: () async => File('assets/fixtures/movies.json').readAsStringSync(),
);
void main() {
  testWidgets(
    'demo navigates to details and back, searches, and clears empty results',
    (tester) async {
      await tester.pumpWidget(MoviesApp(repository: fixtureRepository()));
      await tester.pumpAndSettle();
      expect(find.textContaining('Modo de exemplo'), findsOneWidget);
      await tester.scrollUntilVisible(
        find.byKey(const ValueKey('movie-title-1')),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.ensureVisible(find.byKey(const ValueKey('movie-title-1')));
      await tester.pumpAndSettle();
      await tester.tap(find.byKey(const ValueKey('movie-title-1')));
      await tester.pumpAndSettle();
      expect(find.text('Sinopse'), findsOneWidget);
      expect(find.text('92 min'), findsOneWidget);
      await tester.pageBack();
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.byType(TextField),
        -250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextField), 'inexistente');
      await tester.pump(const Duration(milliseconds: 400));
      await tester.pumpAndSettle();
      await tester.scrollUntilVisible(
        find.text('Nenhum filme encontrado.'),
        250,
        scrollable: find.byType(Scrollable).first,
      );
      expect(find.text('Nenhum filme encontrado.'), findsOneWidget);
      await tester.ensureVisible(find.byTooltip('Limpar busca'));
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Limpar busca'));
      await tester.pumpAndSettle();
      expect(find.text('Além da órbita'), findsWidgets);
      await tester.scrollUntilVisible(
        find.byTooltip('Sobre e créditos'),
        -250,
        scrollable: find.byType(Scrollable).first,
      );
      await tester.pumpAndSettle();
      await tester.tap(find.byTooltip('Sobre e créditos'));
      await tester.pumpAndSettle();
      expect(find.text('Sobre o Movies'), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
  testWidgets('initial error retries and shows catalog', (tester) async {
    final repo = RecoverableRepository();
    await tester.pumpWidget(MoviesApp(repository: repo));
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.text('Sem conexão.'),
      250,
      scrollable: find.byType(Scrollable).first,
    );
    expect(find.text('Sem conexão.'), findsOneWidget);
    repo.fail = false;
    await tester.ensureVisible(find.text('Tentar novamente'));
    await tester.tap(find.text('Tentar novamente'));
    await tester.pumpAndSettle();
    expect(find.text('Além da órbita'), findsWidgets);
  });
  testWidgets('narrow viewport and large text have no layout exception', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(2)),
          child: child!,
        ),
        home: MoviesApp(repository: fixtureRepository()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.scrollUntilVisible(
      find.byKey(const ValueKey('movie-title-1')),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    expect(tester.takeException(), isNull);
  });
  testWidgets('all demo posters render from bundled assets without HTTP', (
    tester,
  ) async {
    final repository = fixtureRepository();
    for (var id = 1; id <= 12; id++) {
      final movie = await repository.detail(id);
      await tester.pumpWidget(
        MaterialApp(
          home: SizedBox(
            width: 200,
            child: Poster(key: ValueKey(id), movie: movie),
          ),
        ),
      );
      await tester.pumpAndSettle();
      expect(find.byType(SvgPicture), findsOneWidget, reason: movie.title);
      expect(find.byType(Image), findsNothing, reason: 'No network poster');
      expect(find.text('ILUSTRAÇÃO • SEM PÔSTER'), findsNothing);
      expect(tester.takeException(), isNull, reason: movie.title);
    }
  });
  testWidgets('missing poster has visible fallback', (tester) async {
    final movie = Movie.fromJson({'id': 1, 'title': 'No poster'});
    await tester.pumpWidget(
      MaterialApp(
        home: SizedBox(width: 200, child: Poster(movie: movie)),
      ),
    );
    expect(find.text('ILUSTRAÇÃO • SEM PÔSTER'), findsOneWidget);
  });
}
