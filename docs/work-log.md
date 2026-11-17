# Modernization log

Date: 2026-11-17. Scope: `kleberandrade/movies-flutter` only.

- Cloned the clean `main` branch at `f78b2a8`; verified origin and found no project/parent AGENTS.md. Read the requested reduced-principles instructions.
- Inspected actual Dart models, controllers, repository, platform builds and existing tests. Found Dart 2.7, Dio 3, live-network-only tests and a versioned read token. Removed the token from current source; documented historical exposure and owner rotation.
- Confirmed Flutter 3.41.9 / Dart 3.11.5. Regenerated native templates and added Web without changing global SDKs or accepting Android licenses.
- Wrote parsing tests first; observed a compile failure for the missing new model, then passed with typed boundary validation. Added a zero-page inconsistency regression, observed its assertion fail and fixed the parser.
- Replaced mutable API models with immutable values and separated transport, sample data, catalog state and UI. Added deterministic HTTP adapter/fixture tests, concurrency and retry tests.
- Built the Portuguese catalog/detail UI with responsive grids, typography, spacing, contrast, debounce search, explicit pagination, loading/error/empty states, image fallback, keyboard actions, enlarged-text layout and TMDB credits.
- Widget tests exposed a real overflow at 200% text size; fixed the header and scaled grid extent. Adjusted test scrolling to lazy slivers; navigation, error recovery, search and missing-poster tests then passed.
- `crapper lib --no-coverage`, `dryer lib --threshold 0.8` and `mutator lib --scan` each reported no supported source files. Their installed language lists do not include Dart. No CRAP, duplication or mutation scores are claimed. Used Dart analyzer and behavioral tests instead.
- Opened and read the actual linked Medium tutorial in the signed-in browser; confirmed the account exposes “Edit story”. Editorial update follows final validation, preserving Portuguese and story identity.
- A temporary disk-full error interrupted formatting; checked file sizes and reran formatting after space returned. Did not delete other projects or their caches.

- Final locked resolution, formatting, analyzer and all 23 tests passed. Release Web, Android debug and iOS debug simulator builds succeeded; iOS needed target 15 and a host-architecture debug setting for Xcode 27 lipo compatibility.
- Inspected the actual compiled Web app in Chrome at desktop and 390×844: search, details/back, empty/clear, density, second page and credits. Fixed metadata roles observed there and enabled Web semantics at startup. Saved real screenshots.
- Published the Portuguese Medium revision, verified the publication alert and new public section, and preserved original notes under an explicit 2020 archive heading. No subscriber messages were sent.
- Updated and read back the GitHub English description plus nine relevant topics. Rewrote current setup/architecture/validation docs in English and preserved the original MIT text in LICENSE.

## Follow-up: packages and full Medium lesson

- Read the user request to refresh the entire article, its cover/images/code and five final exercises. Consulted pub outdated, current package release notes, the official Flutter archive/release notes and Material migration guide.
- Installed Flutter 3.50.0 / Dart 3.14.0 in an exclusive project cache, preserving global SDKs. Updated all direct dependencies and resolvable transitives, migrated Material imports, committed a machine-readable audit and documented the three upstream bounds without overrides.
- Reran all 23 tests, analyzer, Web release, Android ARM64 and iOS simulator builds. Android reproduced an old-Gradle rejection; migrated to the official current host template and rebuilt successfully.
- Added and executed the complete pure-Dart parsing example used in the lesson; included it in formatting and CI checks.
- Generated a new editorial cover, removed an unintended logo in a targeted edit, and saved the final image and prompts in docs/media. Captured the actual updated Web catalog and details at desktop/mobile sizes.
- Replaced the Medium body with a continuous Portuguese lesson, current package versions, code explanations, source references and exactly five final exercises. Preserved original resources in the linked classroom archive. Inserted the new cover and two real screenshots, with descriptions distinguishing illustration from actual app capture. Browser extension upload failed; used the native file picker instead, without changing browser permissions.
- Published the full revision and opened the public story again. Verified current package text, three images loading with alternative descriptions, the new cover as the sharing image, no insertion markers and exactly five final exercise items. Saved publication proof outside Git because it includes browser-account UI.
