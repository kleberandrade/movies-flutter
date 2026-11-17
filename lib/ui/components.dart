import 'package:material_ui/material_ui.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../domain/movie.dart';

const accent = Color(0xffe8be79);

class Poster extends StatelessWidget {
  const Poster({super.key, required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    final fallback = _Artwork(movie: movie);
    return ClipRRect(
      borderRadius: BorderRadius.circular(14),
      child: AspectRatio(
        aspectRatio: 2 / 3,
        child: movie.posterUrl == null
            ? fallback
            : Image.network(
                movie.posterUrl!,
                fit: BoxFit.cover,
                excludeFromSemantics: true,
                loadingBuilder: (context, child, progress) => progress == null
                    ? child
                    : Stack(
                        fit: StackFit.expand,
                        children: [
                          fallback,
                          const Center(child: CircularProgressIndicator()),
                        ],
                      ),
                errorBuilder: (context, error, stack) => fallback,
              ),
      ),
    );
  }
}

class _Artwork extends StatelessWidget {
  const _Artwork({required this.movie});
  final Movie movie;
  @override
  Widget build(BuildContext context) {
    const colors = [
      Color(0xff365d73),
      Color(0xff865649),
      Color(0xff4c6e61),
      Color(0xff58557e),
    ];
    return DecoratedBox(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            colors[(movie.id - 1) % colors.length],
            const Color(0xff141d2b),
          ],
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) => Stack(
          children: [
            Positioned(
              right: -constraints.maxWidth * .2,
              top: constraints.maxHeight * .1,
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxWidth,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white24, width: 1),
                ),
              ),
            ),
            Positioned(
              right: constraints.maxWidth * .2,
              top: constraints.maxHeight * .22,
              child: Icon(
                Icons.auto_awesome_outlined,
                size: constraints.maxWidth * .3,
                color: Colors.white54,
              ),
            ),
            Positioned(
              left: 20,
              right: 16,
              bottom: 22,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'M O V I E S  /  E S T U D O',
                    style: TextStyle(fontSize: 9, color: Colors.white70),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    movie.title,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: (constraints.maxWidth * .12).clamp(16, 32),
                      fontWeight: FontWeight.w600,
                      height: 1.1,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'ILUSTRAÇÃO • SEM PÔSTER',
                    style: TextStyle(fontSize: 9, color: Colors.white70),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FailureNotice extends StatelessWidget {
  const FailureNotice({super.key, required this.message, required this.retry});
  final String message;
  final VoidCallback retry;
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.symmetric(vertical: 24),
    child: Column(
      children: [
        const Icon(Icons.cloud_off_outlined, size: 36, color: accent),
        const SizedBox(height: 12),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 12),
        OutlinedButton.icon(
          onPressed: retry,
          icon: const Icon(Icons.refresh),
          label: const Text('Tentar novamente'),
        ),
      ],
    ),
  );
}

void showCredits(BuildContext context, bool demo) => showDialog<void>(
  context: context,
  builder: (context) => AlertDialog(
    title: const Text('Sobre o Movies'),
    content: SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Um projeto de ensino de Kleber de Oliveira Andrade. Código sob licença MIT.',
          ),
          const SizedBox(height: 16),
          if (demo)
            const Text(
              'Modo de exemplo: histórias, notas e ilustrações fictícias e locais. Nenhum dado foi consultado no TMDB.',
            ),
          const SizedBox(height: 16),
          SvgPicture.asset(
            'assets/tmdb-logo.svg',
            width: 100,
            semanticsLabel: 'TMDB',
          ),
          const SizedBox(height: 12),
          const Text(
            'This product uses the TMDB API but is not endorsed or certified by TMDB.',
          ),
          const SizedBox(height: 8),
          const SelectableText('https://www.themoviedb.org'),
        ],
      ),
    ),
    actions: [
      TextButton(
        onPressed: () => Navigator.pop(context),
        child: const Text('Fechar'),
      ),
    ],
  ),
);

/// Read-only metadata: deliberately has no checkbox/button semantics.
class InfoBadge extends StatelessWidget {
  const InfoBadge({super.key, required this.label, this.avatar});
  final Widget label;
  final Widget? avatar;
  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(
      color: const Color(0xff19212c),
      borderRadius: BorderRadius.circular(8),
      border: Border.all(color: Colors.white24),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (avatar != null) ...[avatar!, const SizedBox(width: 8)],
          Flexible(child: label),
        ],
      ),
    ),
  );
}
