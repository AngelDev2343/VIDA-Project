# VIDA — App espiritual cristiana

Aplicación móvil hecha en **Flutter** (Android + iOS) con temática verde esmeralda, tipografía DM Sans + Cormorant Garamond, y diseño Material 3. Sin gestor de estado externo (solo `setState`), sin soporte de modo oscuro.

---

## Flujo de inicio

1. **SplashScreen** → pide el nombre del usuario (con `TextField` capitalizado) → lo guarda en `SharedPreferences` → llama a `VidaApp.of(context).setUserName(name)`.
2. Si ya hay nombre guardado, va directo al **AppShell** con 4 tabs (Inicio / Biblia / VIDA / Perfil).
3. **Racha** (`StreakService`): al abrir la app se verifica si ya se abrió hoy. Si el último registro fue ayer, suma +1; si no, reinicia la racha. También guarda un historial de fechas para el calendario.

---

## Pantallas / Tabs

### Tab 1 — Inicio (`HomeScreen`)
- Saludo personalizado ("Buenos días, {nombre}")
- `VidaVerseCard`: versículo destacado (Jeremías 29:11) con botones de compartir y guardar
- Widget de racha: días consecutivos + mejor racha, animación al cargar, navega a `StreakScreen` donde se ve un calendario mensual
- **6 herramientas** en grilla 2×2:
  - **Contra pecado** → activa/desactiva widget de frase diaria
  - **Estudio bíblico** → notas de estudio con CRUD
  - **Situación difícil** → versículos categorizados (ansiedad, perdón, fe, relaciones, finanzas, depresión)
  - **Crear imagen** → galería de fondos + editor de texto para compartir
  - **Widget favorito** → activa/desactiva widget de versículo personalizado (50 versículos)
  - **Canciones** → placeholder (música cristiana, aún sin implementar)
- **Mini Arcade**: fila bloqueada, "Próximamente · En desarrollo"

### Tab 2 — Biblia (`BibliaScreen`)
- `WebView` con youversion.com/bible (RVR1960, Juan 1:1)
- Lazy init: el `WebViewController` se crea solo cuando el tab está activo y se destruye al salir
- Detección de conectividad (`connectivity_plus`): si no hay internet muestra mensaje offline con Mateo 28:20

### Tab 3 — VIDA (placeholder)
- "En construcción"

### Tab 4 — Perfil (placeholder)
- "En construcción"

---

## Herramientas del Home

### Contra pecado (`ContraPecadoScreen`)
- **Switch** on/off → guarda estado en `SharedPreferences`
- **7 frases diarias** (una por día de la semana), cada una con imagen de fondo (`contra_img/1.png` … `contra_7.png`)
- Al activar: envía frase + fondo al widget nativo y pide fijarlo en la pantalla de inicio
- Widget Android: `ContraPecadoWidgetProvider`, redondeo con `clipToOutline`, imágenes desde `res/drawable-nodpi/`
- Si el widget fue eliminado, muestra advertencia con botón para reinstalar
- Primer inicio de la app: pin automático del widget (con guarda `first_launch_pin`)

### Estudio bíblico (`EstudioBiblicoScreen`)
- CRUD completo de estudios: crear (`AddEstudioScreen`), ver detalle (`EstudioDetalleScreen`), editar, eliminar (deslizar)
- Cada estudio tiene: nombre, fecha, libro, versículos, reflexión
- Persistencia en `SharedPreferences` como JSON

### Situación difícil (`SituacionDificilScreen`)
- Filtro por categorías: Todos, Ansiedad, Perdón, Fe, Relaciones, Finanzas, Depresión
- Buscador por texto
- Cada consejo (`Consejo`) tiene: categoría, título, descripción, versículo bíblico
- Lista precargada (~30+ consejos en `consejos_data.dart`)

### Crear imagen (`GalleryScreen` → `ImageEditorScreen`)
- Galería de fondos desde `gallery/`
- Editor: superpone texto sobre la imagen
- Personalización: color del texto (7 colores), tamaño (S/M/L), alineación (top/center/bottom)
- Captura con `RepaintBoundary.toImage()` y comparte con `share_plus`

### Widget favorito (`FavoritoScreen`)
- **Switch** on/off + selección de 1 de 50 versículos
- Vista previa del widget con fondo `widget-fav.png`
- Persiste índice en `SharedPreferences`
- Widget Android: `FavoritoWidgetProvider`, mismo patrón que ContraPecado
- Si verso >80 caracteres, tamaño de letra baja de 13sp a 12sp

### Canciones
- Placeholder sin implementar

---

## Widgets nativos (Android)

Ambos widgets usan `home_widget` y el mismo patrón:

| Widget | Frase/Verso diario | Pin automático en primer inicio |
|---|---|---|
| Contra pecado | 7 frases, 1 por día de la semana | Sí |
| Favorito | 50 versículos, elegido por usuario | Sí |

**Reglas compartidas:**
- `setImageViewResource` (NUNCA `setImageViewBitmap` — causa `TransactionTooLargeException`)
- `clipToOutline="true"` en ImageView para bordes redondeados
- Fondos redondeados con `<shape>` de 18dp radius en XML
- Refresco cada 24 horas
- iOS requiere configuración manual de Xcode (App Groups)

---

## Navegación

- `IndexedStack` con 4 tabs mediante `NavigationBar` (M3)
- Sin router package, todo con `Navigator.push` estándar

## Estado

- Solo `setState` (sin Provider, Riverpod, Bloc, etc.)
- Persistencia con `SharedPreferences` (nombre, racha, estudios, estados de widgets, versículo favorito)

## Tema

- **Solo modo claro**, paleta esmeralda (shades 50–900)
- `GoogleFonts.dmSans` para cuerpo/UI, `GoogleFonts.cormorantGaramond` para títulos
- AppBar, íconos, snackbars, NavigationBar, inputs todos diseñados con la paleta `AppColors`
- Sin `debugShowCheckedModeBanner`

## Assets

- `contra_img/` — 7 imágenes para el widget ContraPecado
- `gallery/` — fondos para el editor de imágenes
- `widget-fav.png` — fondo del widget favorito

## Dependencias principales

| Paquete | Uso |
|---|---|
| `google_fonts` | Tipografía DM Sans y Cormorant Garamond |
| `flutter_svg` | Renderizado SVG |
| `shared_preferences` | Persistencia local (nombre, racha, estudios, widgets) |
| `home_widget` | Widgets nativos Android (ContraPecado y Favorito) |
| `webview_flutter` | Biblia en WebView |
| `connectivity_plus` | Detección de internet para Biblia |
| `share_plus` | Compartir imágenes |
| `path_provider` | Guardado temporal de imágenes |

## Tests

- Un solo archivo: `test/widget_test.dart`
- Usa `tester.pump()` (no `pumpAndSettle` — la transición splash→home depende de SharedPreferences y timeout)
- `SharedPreferences.setMockInitialValues({})` obligatorio antes de `pumpWidget`
