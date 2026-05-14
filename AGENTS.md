# vida_app — agent guide

## Commands

```bash
flutter pub get          # install deps
flutter analyze          # lint (package:flutter_lints/flutter.yaml, no custom rules)
flutter test             # runs widget_test.dart
flutter run              # launch on device/emulator
```

## Package name vs directory

`pubspec.yaml` declares `name: vida_app` but lives in a `vida_project` folder. Imports use `package:vida_app/...`.

## Known issues

- **Placeholder tabs**: Only `HomeScreen` is wired. Biblia / VIDA / Perfil tabs are `_PlaceholderScreen` stubs.
- **Test requires mock prefs**: `SharedPreferences.setMockInitialValues({})` must be called before `VidaApp` in tests (already done).

## Architecture

- **Entrypoint**: `lib/main.dart` — `VidaApp`, light-only M3 theme.
- **Splash flow**: `SplashScreen` asks user's name → saves to `SharedPreferences` → transitions to `AppShell`. Name accessed via `VidaApp.of(context).userName`.
- **Theme**: `lib/theme/app_theme.dart` — single light theme, emerald palette (`AppColors`, shades 50–900). Uses `GoogleFonts.dmSans` + `GoogleFonts.cormorantGaramond`. No dark theme.
- **State**: `setState` only (no state management). User name in `_VidaAppState`.
- **Navigation**: `NavigationBar` (M3) wrapped in `NavigationBarTheme` for icon colors + `IndexedStack` for 4 tabs (Inicio / Biblia / VIDA / Perfil). No router package.
- **Dependencies**: `google_fonts`, `flutter_svg`, `cupertino_icons`, `shared_preferences`. Dev: `flutter_test`, `flutter_lints`.
- **Color contrast**: All text on white uses emerald600 or darker. AppBar icons use `emerald700`. NavBar indicator is `emerald100` with selected icons in `emerald700`, unselected in `emerald400`.
