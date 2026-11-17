# Architecture and migration

The app keeps the classroom catalog/detail flow and adds search, explicit pagination and a self-contained sample mode. The old Dart 2 / Dio 3 implementation is available in Git history and [archived classroom material](classroom-2020.md).

## Data flow

`main.dart` selects a repository once. UI → `CatalogController` → `MovieRepository` → Dio or bundled JSON. Details own a `Future<Movie>` and retry that operation independently. Widgets do not parse JSON or configure HTTP.

- **Movie**: immutable identity, title, optional poster/date/runtime, score, synopsis, genre names and original language. JSON identity, types, score range, dates and image paths are checked on entry. Missing optional information has explicit UI fallbacks.
- **MoviePage**: one response page; API pagination is capped at TMDB's 500-page limit. Zero total pages means empty results.
- **MovieRepository**: catalog/search and detail contract. `TmdbRepository` receives Dio for deterministic adapter tests. It sends the read token as a Bearer header and maps HTTP/transport/format failures to safe messages, without displaying raw server payloads.
- **DemoRepository**: original fictional JSON, six movies per page, local title search and complete sample details. It never silently replaces a failed API request.
- **CatalogController**: one owner for query, items, pagination, loading and error. A generation counter invalidates old work immediately when typing starts, before the 350 ms debounce dispatch. Obsolete futures are ignored, including after disposal. Network calls already sent are not canceled. Next-page requests are serialized, duplicate IDs are merged, failure preserves loaded items and retries the same page.

## Migration decisions

Dart null safety replaces nullable implicit fields. Dio 5 uses `Duration` timeouts and `DioException`. Removed dartz and intl: typed failures and a year-only label meet current needs without those dependencies. Internal Dart 2 controller/model constructors are intentionally replaced; this application does not publish a Dart library API.

Android and iOS platform scaffolds were regenerated with Flutter 3.41.9, preserving `com.example.movies` (a classroom identifier, change it before distribution). Android uses the declarative Gradle plugin DSL, AGP 8.11.1, Kotlin 2.2.20 and Gradle 8.14. iOS uses the current scene lifecycle and iOS 15 minimum (required by the validated Xcode 27.2 simulator SDK). Debug simulator builds select their host architecture to avoid the Xcode 27 multi-architecture lipo issue; device/release settings retain the template defaults. Web is new. Existing iOS artwork and original MIT attribution are preserved. Android release signing still uses the template debug key for local builds; configure real signing before any store distribution.

## Boundaries and limits

No account/login, watchlist, favorites, playback, persistent API cache, deep-link restoration or automatic infinite scrolling. A labeled load-more button is keyboard accessible and makes request boundaries explicit. In live mode, connectivity errors keep existing pages and offer retry; a fresh live catalog needs network access. Demo assets need no TMDB connection after the application resources are loaded.

`--dart-define` is external configuration, not secret storage: compiled Web/mobile apps expose embedded read tokens to their users. For a distributed production app, keep credentials behind your own authenticated backend, comply with TMDB's terms, and avoid an unrestricted proxy. No real integration is claimed without an authorized token and an executed request.

The previously committed token was removed from current source. It remains in Git history and must be revoked/rotated by its owner in TMDB. History was not rewritten.

## Attribution

The official TMDB logo is bundled from [Logos & Attribution](https://www.themoviedb.org/about/logos-attribution). SVG CSS is inlined to the equivalent `fill` attribute for Flutter rendering; path geometry, gradient, colors and proportions are unchanged. TMDB branding/data are governed by TMDB terms, not the repository's MIT code license. The About dialog includes the logo and required non-endorsement notice.

Official references checked during migration: [authentication](https://developer.themoviedb.org/docs/authentication-application), [popular](https://developer.themoviedb.org/reference/movie-popular-list), [search](https://developer.themoviedb.org/reference/search-movie), [images](https://developer.themoviedb.org/docs/image-basics), [FAQ and usage](https://developer.themoviedb.org/docs/faq), [Dio](https://pub.dev/packages/dio).
