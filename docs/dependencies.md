# Dependency audit — 2026-11-17

Current toolchain: **Flutter 3.50.0 stable / Dart 3.14.0**. The SDK was installed in an isolated project cache; the global Flutter installation and other projects were not modified. `.fvmrc` and GitHub Actions pin 3.50.0.

All direct hosted dependencies and development dependencies are at their latest available stable releases observed on this date:

- `dio` 5.11.1: HTTPS client and injectable test adapter.
- `flutter_svg` 2.4.0: official TMDB logo rendering.
- `cupertino_icons` 2.0.0: adaptive-control icon font.
- `material_ui` 1.11.1: current standalone Material design library.
- `flutter_lints` 6.0.0: static analysis rules.
- `flutter` and `flutter_test`: from the pinned Flutter 3.50.0 SDK, with package version `0.0.0` by SDK convention.

The major-version upgrade also updates resolvable transitives, including clock 1.1.3, matcher 0.12.20, meta 1.19.0, petitparser 7.1.0, stack_trace 1.12.2, vector_math 2.4.4 and web 1.1.2. Standalone Material adds cupertino_ui 1.1.7 and intl 0.20.3 transitively. Every exact resolution and integrity hash is in `pubspec.lock`; the current outdated report is in [dependency-audit.json](dependency-audit.json).

## Upstream constraints preserved

Three transitive packages have newer releases outside the current upstream constraints:

- `material_color_utilities`: resolved **0.13.0**, latest **0.13.1**. Flutter 3.50.0's own `packages/flutter/pubspec.yaml` pins 0.13.0.
- `test_api`: resolved **0.7.14**, latest **0.7.15**. Flutter 3.50.0's `packages/flutter_test/pubspec.yaml` pins 0.7.14.
- `xml`: resolved **7.0.1**, latest **7.1.0**. `vector_graphics_compiler` 1.3.6 explicitly bounds XML to `>=6.3.0 <=7.0.1` and documents that its upper bound reflects audited source versions.

No `dependency_overrides` were added to bypass these limits. “All direct dependencies up to date” does not mean every transitive package has the numerically latest version. Revisit this report when Flutter and the SVG compiler update their constraints.

## Migration and verification

Imports in app and widget tests now use `package:material_ui/material_ui.dart`, following the [official Flutter migration](https://docs.flutter.dev/release/breaking-changes/material-ui-and-cupertino-ui). The old `package:flutter/material.dart` import is deprecated in Flutter 3.50. The SVG and Cupertino package release notes require at least Flutter 3.44 / Dart 3.12, which is why changing only package numbers on the previous SDK was insufficient.

Android build files follow the official Flutter 3.50 template: Gradle **9.5.0**, AGP **9.3.1**, Kotlin **2.4.20**, Java 17 bytecode target. `com.example.movies` and the INTERNET permission are preserved. The minimum supported Gradle version rejected the earlier host, so its build was migrated instead of bypassing validation. iOS remains at deployment target 15 with its existing debug simulator host-architecture setting.

Run `flutter pub get --enforce-lockfile`, `flutter pub outdated`, `flutter analyze --no-pub`, `flutter test --no-pub --concurrency=1 --coverage` and the Web/native build commands in the README. See [validation.md](validation.md) for the actual results and limits.
