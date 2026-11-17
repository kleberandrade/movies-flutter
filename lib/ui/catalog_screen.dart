import 'dart:async';

import 'package:material_ui/material_ui.dart';

import '../data/movie_repository.dart';
import '../domain/movie.dart';
import '../state/catalog_controller.dart';
import 'components.dart';
import 'detail_screen.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key, required this.repository});
  final MovieRepository repository;
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late final CatalogController controller;
  final search = TextEditingController();
  Timer? debounce;
  bool compact = false;
  @override
  void initState() {
    super.initState();
    controller = CatalogController(widget.repository)..search('');
  }

  @override
  void dispose() {
    debounce?.cancel();
    search.dispose();
    controller.dispose();
    super.dispose();
  }

  void changeQuery(String value) {
    debounce?.cancel();
    // Invalidate in-flight responses immediately; debounce only the dispatch.
    controller.invalidateSearch();
    debounce = Timer(
      const Duration(milliseconds: 350),
      () => controller.search(value),
    );
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    body: SafeArea(
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1200),
          child: ListenableBuilder(
            listenable: controller,
            builder: (context, _) => CustomScrollView(
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.local_movies_outlined,
                              color: accent,
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              child: Text(
                                'movies',
                                style: TextStyle(
                                  fontSize: 26,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: -1,
                                ),
                              ),
                            ),
                            IconButton(
                              onPressed: () => showCredits(
                                context,
                                widget.repository.isDemo,
                              ),
                              tooltip: 'Sobre e créditos',
                              icon: const Icon(Icons.info_outline),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                        Text(
                          widget.repository.isDemo
                              ? 'UM CATÁLOGO PARA EXPLORAR'
                              : 'SEU PRÓXIMO FILME',
                          style: const TextStyle(
                            color: accent,
                            letterSpacing: 2,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'Boas histórias\ncomeçam aqui.',
                          style: Theme.of(context).textTheme.headlineLarge,
                        ),
                        const SizedBox(height: 12),
                        const Text(
                          'Explore filmes, encontre uma história e descubra os detalhes.',
                          style: TextStyle(
                            color: Color(0xffb8c2d2),
                            height: 1.6,
                          ),
                        ),
                        const SizedBox(height: 24),
                        if (widget.repository.isDemo)
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: const Color(0xff25302d),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.science_outlined,
                                  size: 20,
                                  color: accent,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Modo de exemplo · Filmes e notas fictícios. Funciona sem internet.',
                                    style: TextStyle(color: Color(0xffd6dfd5)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: search,
                          onChanged: changeQuery,
                          onSubmitted: (value) {
                            debounce?.cancel();
                            controller.search(value);
                          },
                          textInputAction: TextInputAction.search,
                          decoration: InputDecoration(
                            labelText: 'Buscar filmes',
                            hintText: 'Qual história você procura?',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: IconButton(
                              tooltip: 'Limpar busca',
                              onPressed: () {
                                search.clear();
                                debounce?.cancel();
                                controller.search('');
                              },
                              icon: const Icon(Icons.close),
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                controller.query.isEmpty
                                    ? 'Em destaque'
                                    : 'Resultados da busca',
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                            ),
                            IconButton(
                              tooltip: compact
                                  ? 'Cartões maiores'
                                  : 'Cartões menores',
                              onPressed: () =>
                                  setState(() => compact = !compact),
                              icon: Icon(
                                compact ? Icons.grid_view : Icons.apps,
                              ),
                            ),
                          ],
                        ),
                        Text(
                          '${controller.movies.length} ${controller.movies.length == 1 ? 'filme' : 'filmes'} nesta seleção',
                          style: const TextStyle(color: Color(0xffb8c2d2)),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  sliver: SliverLayoutBuilder(
                    builder: (context, constraints) {
                      final columns =
                          (constraints.crossAxisExtent / (compact ? 160 : 220))
                              .floor()
                              .clamp(1, 5);
                      return SliverGrid(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) => _MovieCard(
                            movie: controller.movies[index],
                            open: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => DetailScreen(
                                  id: controller.movies[index].id,
                                  repository: widget.repository,
                                ),
                              ),
                            ),
                          ),
                          childCount: controller.movies.length,
                        ),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: columns,
                          mainAxisExtent:
                              (constraints.crossAxisExtent -
                                      (columns - 1) * 20) /
                                  columns *
                                  1.5 +
                              MediaQuery.textScalerOf(context).scale(100),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 20,
                        ),
                      );
                    },
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.all(24),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        if (controller.loading)
                          const Padding(
                            padding: EdgeInsets.all(24),
                            child: CircularProgressIndicator(
                              semanticsLabel: 'Carregando filmes',
                            ),
                          ),
                        if (controller.error != null)
                          FailureNotice(
                            message: controller.error!,
                            retry: controller.loadMore,
                          ),
                        if (!controller.loading &&
                            controller.error == null &&
                            controller.movies.isEmpty) ...[
                          const Icon(Icons.search_off, size: 42, color: accent),
                          const SizedBox(height: 12),
                          const Text('Nenhum filme encontrado.'),
                          const Text(
                            'Experimente outro título ou limpe a busca.',
                          ),
                        ],
                        if (controller.hasMore &&
                            !controller.loading &&
                            controller.error == null)
                          OutlinedButton.icon(
                            onPressed: controller.loadMore,
                            icon: const Icon(Icons.add),
                            label: const Text('Carregar mais filmes'),
                          ),
                        const SizedBox(height: 32),
                        const Divider(),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () =>
                              showCredits(context, widget.repository.isDemo),
                          child: const Text(
                            'Movies / Projeto de ensino · Sobre e créditos',
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );
}

class _MovieCard extends StatelessWidget {
  const _MovieCard({required this.movie, required this.open});
  final Movie movie;
  final VoidCallback open;
  @override
  Widget build(BuildContext context) => Semantics(
    button: true,
    label:
        'Ver detalhes de ${movie.title}, ${movie.year}, nota ${movie.rating.toStringAsFixed(1)} de 10',
    child: InkWell(
      onTap: open,
      borderRadius: BorderRadius.circular(14),
      child: ExcludeSemantics(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Poster(movie: movie),
            const SizedBox(height: 12),
            Text(
              movie.title,
              key: ValueKey('movie-title-${movie.id}'),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 6),
            Row(
              children: [
                Expanded(
                  child: Text(
                    movie.year,
                    style: const TextStyle(color: Color(0xffb8c2d2)),
                  ),
                ),
                const Icon(Icons.star_rounded, color: accent, size: 17),
                const SizedBox(width: 4),
                Text(movie.rating.toStringAsFixed(1)),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}
