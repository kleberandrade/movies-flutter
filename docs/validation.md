# Verified validation

## Follow-up: bundled sample posters

The 12 fictional movies now have distinct original SVG posters bundled in `assets/posters/` (16,823 bytes total). A new widget regression first failed because no poster was rendered, then passed for every bundled image without a network `Image`. Fixture tests also verify unique existing poster files and matching catalog/detail paths. Boundary tests reject unsafe local paths; TMDB parsing ignores the fixture-only `poster_asset` field.

Locked resolution, formatting, analyzer, **25 behavioral tests**, the executable parsing example, Web release and Android ARM64 debug builds passed. All 12 SVG contents were compared byte-for-byte with their entries in the Web build and Android APK. No dependency or toolchain changes were necessary. The README's incorrect Dart patch number was aligned with the actual SDK (3.14.0).

Actual compiled Web cards and details were inspected at desktop and **390 × 844**, with no warning/error console entries in the mobile session. All four repository screenshots were refreshed. The demo uses no remote poster source; tests run with Flutter's test HTTP restrictions. A fully disconnected browser reload/service-worker cache and native-device execution were not tested. iOS was not rebuilt for this asset follow-up; its successful build below predates these poster changes.

## Follow-up: current dependencies and complete tutorial

The current project is verified with **Flutter 3.50.0 / Dart 3.14.0** in a project-specific SDK cache. All direct hosted packages were upgraded to current stable releases; three upstream transitive limits are documented in [dependencies.md](dependencies.md). The old results below remain historical evidence for the initial migration.

Current checks passed: locked dependency resolution, analyzer without issues, **23 behavioral tests**, the executable `example/parse_movie.dart`, release Web build with local renderer resources, debug Android ARM64 APK, and debug iOS simulator build. Android required migrating to the Flutter 3.50 template (Gradle 9.5.0 / AGP 9.3.1 / Kotlin 2.4.20); the first build correctly rejected old Gradle 8.14 and no validation bypass was used.

The compiled current Web app was opened in the in-app Chromium browser, using local sample data. Search `farol`, detail navigation, back, clear, density and a 390 × 844 viewport were verified, and screenshots refreshed. These are browser screenshots, not device tests. The article uses an explicitly described AI editorial cover and two actual updated screenshots with alternative descriptions.

No new live TMDB integration or physical-device test is claimed. crapper/dryer/mutator still do not support Dart.

## Initial modernization results (Flutter 3.41.9)

Environment observed on 2026-11-17: macOS 27.2.1 arm64, Flutter 3.41.9, Dart 3.11.5, Chrome, Xcode 27.2. No global SDK modifications, license acceptance, package publication or deployment.

## Completed

- Locked dependency resolution: `flutter pub get --enforce-lockfile`.
- Formatting: `dart format --output=none --set-exit-if-changed lib test` (no changes).
- Static checks: `flutter analyze --no-pub` (no issues).
- Behavioral suite: `flutter test --no-pub --concurrency=1 --coverage` (**23 tests passed**). Coverage generated, no advertised percentage or mutation score.
- Release Web: `flutter build web --no-pub --release --no-web-resources-cdn` succeeded. The SDK's Wasm dry run also succeeded; a Wasm release was not built or tested.
- Android: `flutter build apk --debug --no-pub` succeeded, followed by a final `flutter build apk --debug --no-pub --target-platform android-arm64` build after the accessibility adjustments. No new licenses were accepted despite doctor reporting pending licenses for some SDK components.
- iOS: `flutter build ios --simulator --debug --no-pub` succeeded after raising the deployment target to iOS 15 and selecting the host architecture for debug simulator builds. No simulator interaction, device execution, signing, archive or store distribution is claimed.
- Real Chrome session of the compiled Web demo served on `127.0.0.1:8784`: catalog render, search `farol`, matching detail navigation, back, search `xyz` empty state, clear, density toggle, load second page (12 local movies), and About dialog with official logo. Checked desktop and **390 × 844** viewport. Enabled Web semantics at initialization; confirmed cards are named buttons and detail metadata reads as text. Screenshots are actual browser captures in [screenshots](screenshots/), not generated mockups. The narrow catalog capture uses compact density after loading page two.
- Widget tests additionally verify a 390 × 844 layout at 200% text scaling; this does not replace a comprehensive assistive-technology audit.
- GitHub description updated in English and nine topics read back: dart, dio, education, flutter, flutter-web, material-design, movies, null-safety, tmdb.
- Own linked Medium article read, edited and publication confirmed at the same story URL; see [Portuguese revision record](medium-update.pt-BR.md).

## Issues reproduced and resolved

Tests caught inconsistent zero-page payloads and a header overflow at 200% text size. The parser/header/grid extent were fixed. Real Web inspection caught static metadata announced as checkboxes; the metadata component now has read-only semantics.

Xcode 27.2 rejected iOS 13. After raising the target, Flutter 3.41.9's multi-architecture `lipo -verify_arch` call failed even though both simulator slices existed. This matches [Flutter issue 188461](https://github.com/flutter/flutter/issues/188461). The project limits debug simulator `ARCHS` to `NATIVE_ARCH_ACTUAL`; the successful build validates that local workaround. Release/device builds retain their template architecture settings.

Disk exhaustion temporarily interrupted formatting and one test compilation. Source integrity was checked and all validations above rerun successfully. Only this project's completed Android intermediate output was removed to reclaim space; other chats' files and global SDKs were left alone.

## Not verified

No authorized live TMDB request was executed, so real API behavior, current movie data and live image delivery are not certified. Transport behavior is tested with a deterministic Dio adapter. No physical Android/iOS device test, Android emulator interaction, iOS simulator interaction, store release or production backend integration was performed. Web was tested online with local sample assets; network-disconnected browser reload/service-worker caching was not tested.

Installed crapper/dryer/mutator do not support Dart and reported no source files. Their absence of results is not a passing quality or mutation score. CI validates the pinned Web/test workflow; native builds above are local checks.
