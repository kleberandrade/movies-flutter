import 'package:material_ui/material_ui.dart';

import '../data/movie_repository.dart';
import '../domain/movie.dart';
import 'components.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key, required this.id, required this.repository});
  final int id;
  final MovieRepository repository;
  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<Movie> movie;
  @override
  void initState() {
    super.initState();
    movie = widget.repository.detail(widget.id);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Detalhes do filme'),
      actions: [
        IconButton(
          tooltip: 'Sobre e créditos',
          onPressed: () => showCredits(context, widget.repository.isDemo),
          icon: const Icon(Icons.info_outline),
        ),
      ],
    ),
    body: FutureBuilder<Movie>(
      future: movie,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(
            child: FailureNotice(
              message: snapshot.error is MovieFailure
                  ? (snapshot.error as MovieFailure).message
                  : 'Não foi possível abrir o filme.',
              retry: () =>
                  setState(() => movie = widget.repository.detail(widget.id)),
            ),
          );
        }
        if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(
              semanticsLabel: 'Carregando detalhes',
            ),
          );
        }
        final m = snapshot.data!;
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1050),
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final content = Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.repository.isDemo)
                        const InfoBadge(
                          label: Text('EXEMPLO FICTÍCIO'),
                          avatar: Icon(Icons.science_outlined, size: 18),
                        ),
                      const SizedBox(height: 16),
                      Text(
                        m.title,
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                      const SizedBox(height: 12),
                      Wrap(
                        spacing: 12,
                        runSpacing: 8,
                        children: [
                          InfoBadge(
                            label: Text(m.year),
                            avatar: const Icon(
                              Icons.calendar_today_outlined,
                              size: 16,
                            ),
                          ),
                          InfoBadge(
                            label: Text(
                              'Nota ${m.rating.toStringAsFixed(1)} / 10',
                            ),
                            avatar: const Icon(
                              Icons.star_rounded,
                              size: 18,
                              color: accent,
                            ),
                          ),
                          if (m.runtime != null && m.runtime! > 0)
                            InfoBadge(label: Text('${m.runtime} min')),
                          if (m.language.isNotEmpty)
                            InfoBadge(
                              label: Text(
                                'Idioma: ${m.language.toUpperCase()}',
                              ),
                            ),
                        ],
                      ),
                      if (m.genres.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 12),
                          child: Text(
                            m.genres.join(' · '),
                            style: const TextStyle(color: accent),
                          ),
                        ),
                      if (m.tagline.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 24),
                          child: Text(
                            m.tagline,
                            style: const TextStyle(
                              fontSize: 20,
                              fontStyle: FontStyle.italic,
                              color: Color(0xffb8c2d2),
                            ),
                          ),
                        ),
                      const SizedBox(height: 24),
                      Text(
                        'Sinopse',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text(
                        m.overview.isEmpty
                            ? 'Sinopse ainda não disponível.'
                            : m.overview,
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                      const SizedBox(height: 32),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        widget.repository.isDemo
                            ? 'História original criada para demonstrar o aplicativo.'
                            : 'Dados e imagens: The Movie Database (TMDB).',
                        style: const TextStyle(color: Color(0xffb8c2d2)),
                      ),
                    ],
                  );
                  return constraints.maxWidth < 650
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: SizedBox(
                                width: 220,
                                child: ExcludeSemantics(
                                  child: Poster(movie: m),
                                ),
                              ),
                            ),
                            const SizedBox(height: 24),
                            content,
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              width: 280,
                              child: ExcludeSemantics(child: Poster(movie: m)),
                            ),
                            const SizedBox(width: 48),
                            Expanded(child: content),
                          ],
                        );
                },
              ),
            ),
          ),
        );
      },
    ),
  );
}
