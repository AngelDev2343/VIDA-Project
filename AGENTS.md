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

## Test quirks

- **Only one test file**: `test/widget_test.dart`. No test runner config — just `flutter test`.
- **`pump` not `pumpAndSettle`**: Tests call `await tester.pump()` (single frame) after `pumpWidget`. Do NOT use `pumpAndSettle` — the splash → home transition depends on `SharedPreferences` and would time out.
- **Mock prefs required**: `SharedPreferences.setMockInitialValues({})` must be called before `VidaApp` in tests (already done in existing tests).

## Architecture

- **Entrypoint**: `lib/main.dart` — `VidaApp`, light-only M3 theme, no `debugShowCheckedModeBanner`.
- **Splash flow**: `SplashScreen` (`lib/screens/splash_screen.dart`) asks user's name via `TextField` (word-capitalized) → saves to `SharedPreferences` → calls `VidaApp.of(context).setUserName(name)`. Name accessed via `VidaApp.of(context).userName`.
- **Home screen**: `HomeScreen` (`lib/screens/home_screen.dart`) shows greeting, `VidaVerseCard`, streak widget, 6 `ToolCard` tools, and a locked "Mini Arcade" row.
- **Placeholder tabs**: Tabs 2–4 (Biblia / VIDA / Perfil) are `_PlaceholderScreen` (private class in `main.dart`) — "En construcción" stubs.
- **Widgets**: `lib/widgets/` — `vida_verse_card.dart`, `tool_card.dart`, `fade_in.dart`, `contra_pecado_card.dart`, `favorito_card.dart`.
- **Data layer**: `lib/data/` — `phrases.dart` (7 daily phrases), `fav.dart` (50 `FavVerse` objects), `bible_study.dart` (CRUD via SharedPreferences JSON), `consejo.dart` + `consejos_data.dart` (situation advice), `gallery_images.dart` (20 image paths), `streak.dart` (`StreakService`).
- **Theme**: `lib/theme/app_theme.dart` — single light theme, emerald palette (`AppColors`, shades 50–900). Uses `GoogleFonts.dmSans` + `GoogleFonts.cormorantGaramond`. No dark theme.
- **State**: `setState` only (no state management). User name in `_VidaAppState`.
- **Navigation**: `NavigationBar` (M3) wrapped in `NavigationBarTheme` for icon colors + `IndexedStack` for 4 tabs (Inicio / Biblia / VIDA / Perfil). No router package.
- **Biblia WebView**: `BibliaScreen` receives `isActive` prop — creates `WebViewController` **only** when tab is selected and disposes it when switching away (lazy init + memory cleanup). Uses `connectivity_plus` to detect offline.
- **Image editor**: `GalleryScreen` → `ImageEditorScreen` renders background + editable text overlay, captures via `RepaintBoundary.toImage()`, shares via `share_plus`.
- **Bible study**: `EstudioBiblicoScreen` — CRUD list stored as JSON string in SharedPreferences, swipe-to-delete with `Dismissible`.
- **Dependencies** (from `pubspec.yaml`): `google_fonts`, `flutter_svg` (unused in Dart code), `cupertino_icons`, `shared_preferences`, `home_widget`, `webview_flutter`, `connectivity_plus`, `share_plus`, `path_provider`. Dev: `flutter_test`, `flutter_lints`.
- **`withValues(alpha:)` not `withOpacity`**: Codebase uses `Colors.white.withValues(alpha: 0.07)` — `withOpacity` is not used anywhere (deprecated in newer Flutter).
- **Color contrast**: All text on white uses emerald600 or darker. AppBar icons use `emerald700`. NavBar indicator is `emerald100` with selected icons in `emerald700`, unselected in `emerald400`.

## Kotlin widget providers

Android widget code lives in `android/app/src/main/kotlin/com/vida/project/` — `ContraPecadoWidgetProvider.kt` and `FavoritoWidgetProvider.kt`. Both extend `HomeWidgetProvider` from the `home_widget` package.

## "Contra pecado" — home‑screen widget (Android only)

- **Toggle**: `ContraPecadoScreen` (`lib/screens/contra_pecado_screen.dart`) — switch on/off, saved to `SharedPreferences` key `contra_pecado`.
- **Daily phrase**: 7 phrases in `lib/data/phrases.dart`, one per weekday (`DateTime.now().weekday`). Each has a background image in `contra_img/` (also copied to `res/drawable-nodpi/contra_1.png` … `contra_7.png`).
- **Native provider**: `ContraPecadoWidgetProvider` uses `setImageViewResource` + `android:clipToOutline="true"` for rounded corners (NOT `setImageViewBitmap`, which causes `TransactionTooLargeException` on Binder).
- **First‑launch pin**: `_loadUser()` in `_VidaAppState` (`main.dart`) eagerly fires `requestPinWidget` without blocking `_ready`. No `addPostFrameCallback` delay. Guard flag `first_launch_pin` in SharedPreferences.

## "Widget favorito" — home‑screen widget (Android only)

- **Toggle**: `FavoritoScreen` (`lib/screens/favorito_screen.dart`) — switch on/off + scrollable list of 50 verses, saved to `SharedPreferences` key `favorito`.
- **Verse data**: `lib/data/fav.dart` — 50 `FavVerse` objects (referencia + versiculo).
- **Native provider**: `FavoritoWidgetProvider` — same pattern as ContraPecado — `setImageViewResource` + `clipToOutline`. If verse is >80 chars, text size drops from 13sp to 12sp.
- **Preview card**: `favorito_card.dart` (`lib/widgets/`) and `_previewCard()` in `FavoritoScreen` use `Stack` + `Image.asset('widget-fav.png')` + semi‑transparent white container overlay.
- **Image**: `widget-fav.png` (570×570) in both `res/drawable-nodpi/` and Flutter assets.

## Widget native — shared rules

- **Never use `setImageViewBitmap`** in widget providers. Bitmaps are serialised through Binder (1 MB limit) → `TransactionTooLargeException` → "Problem loading widget". Always use `setImageViewResource` + `android:clipToOutline="true"` on the `ImageView` in the layout XML.
- **Rounded corners**: `res/drawable/contra_pecado_bg.xml` and `favorito_bg.xml` are `<shape>` with `<corners android:radius="18dp" />` (no fill). Used as both the `ImageView` background and the `FrameLayout` background for proper clipping.
- **Widget info XMLs**: `res/xml/contra_pecado_widget_info.xml` and `favorito_widget_info.xml` — min 294×146 dp, 24 h refresh.
- **Manifest receivers**: Both providers declared in `AndroidManifest.xml` with `.ContraPecadoWidgetProvider` / `.FavoritoWidgetProvider`.
- **Pin‑duplication guard**: `ContraPecadoScreen._toggle` checks `first_launch_pin` before calling `requestPinWidget` to avoid placing a second widget if already pinned on first launch. `_repin` always requests a pin (user explicitly wants to re‑add).
- **iOS**: Both widgets need manual Xcode extension target setup (App Groups, same bundle‑ID suffix).

## Resources

| Widget | Provider class | Layout | Info XML | Drawable‑nodpi | Rounded bg |
|---|---|---|---|---|---|
| ContraPecado | `ContraPecadoWidgetProvider` | `contra_pecado_widget.xml` | `contra_pecado_widget_info.xml` | `contra_1.png`…`contra_7.png` | `contra_pecado_bg.xml` |
| Favorito | `FavoritoWidgetProvider` | `favorito_widget.xml` | `favorito_widget_info.xml` | `widget_fav.png` | `favorito_bg.xml` |
