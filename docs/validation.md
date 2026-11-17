# Verified validation

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
