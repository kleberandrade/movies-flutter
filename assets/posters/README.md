# Original sample posters

Twelve original vector illustrations for the fictional teaching movies, under the project's MIT license. Created directly as SVG geometry for this app; no third-party posters, external images, fonts or remote resources are embedded. These are not TMDB movie artworks or screenshots. Each 400 × 600 composition uses shapes and gradients and remains sharp at different card sizes.

The `poster_asset` field in `assets/fixtures/movies.json` maps each fictional movie to its own SVG. `Movie.fromDemoJson` validates the `assets/posters/<slug>.svg` namespace. Live TMDB parsing ignores this fixture-only field and continues using `poster_path` for network images. `Poster` uses `SvgPicture.asset` for the demo; both catalog and detail reuse it. Missing artwork retains the labeled fallback.

`flutter.assets` registers the poster directory. The complete SVG set is about 17 KB, so there is no poster download at runtime. On Web, app files still need to be served/loaded; this does not add an offline service-worker cache or promise a first browser visit without a locally available Web build.
