import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/fav.dart';
import '../theme/app_theme.dart';

class FavoritoScreen extends StatefulWidget {
  const FavoritoScreen({super.key});

  @override
  State<FavoritoScreen> createState() => _FavoritoScreenState();
}

class _FavoritoScreenState extends State<FavoritoScreen> {
  bool _enabled = false;
  bool _widgetMissing = false;
  int? _selectedIndex;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final prefs = await SharedPreferences.getInstance();
    final enabled = prefs.getBool('favorito') ?? false;
    final selected = prefs.getInt('fav_index');
    if (mounted) {
      setState(() {
        _enabled = enabled;
        _selectedIndex = selected;
      });
    }

    if (enabled) {
      try {
        final widgets = await HomeWidget.getInstalledWidgets();
        final found = widgets.any(
          (w) =>
              (w.androidClassName?.contains('FavoritoWidgetProvider') ??
                  false),
        );
        if (mounted) setState(() => _widgetMissing = !found);
      } catch (_) {}
    }
  }

  Future<void> _toggle(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorito', value);
    setState(() {
      _enabled = value;
      _widgetMissing = false;
    });

    await HomeWidget.saveWidgetData('favorito', value);

    try {
      if (value) {
        final index = _selectedIndex ?? 0;
        await prefs.setInt('fav_index', index);
        if (mounted) setState(() => _selectedIndex = index);
        await _pushToWidget(index);
        final firstFavPin = prefs.getBool('first_launch_fav_pin') ?? false;
        if (!firstFavPin) {
          await prefs.setBool('first_launch_fav_pin', true);
          final supported =
              await HomeWidget.isRequestPinWidgetSupported() ?? false;
          if (supported) {
            await HomeWidget.requestPinWidget(
              androidName: 'FavoritoWidgetProvider',
            );
          }
          if (mounted && !supported) _showManualPinDialog();
        }
        if (mounted) {
          Navigator.pop(context);
        }
      } else {
        await HomeWidget.saveWidgetData('fav_ref', '');
        await HomeWidget.saveWidgetData('fav_verse', '');
        await HomeWidget.updateWidget(
          androidName: 'FavoritoWidgetProvider',
          iOSName: 'FavoritoWidget',
        );
        if (mounted) {
          Navigator.pop(context);
        }
      }
    } catch (_) {
      if (mounted) Navigator.pop(context);
    }
  }

  Future<void> _selectVerse(int index) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('fav_index', index);
    setState(() => _selectedIndex = index);

    if (_enabled) {
      await _pushToWidget(index);
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Versículo actualizado: ${favVerses[index].referencia}'),
            duration: const Duration(milliseconds: 1200),
          ),
        );
      }
    }
  }

  Future<void> _pushToWidget(int index) async {
    final verse = favVerses[index];
    await HomeWidget.saveWidgetData('fav_ref', verse.referencia);
    await HomeWidget.saveWidgetData('fav_verse', verse.versiculo);
    await HomeWidget.updateWidget(
      androidName: 'FavoritoWidgetProvider',
      iOSName: 'FavoritoWidget',
    );
  }

  Future<void> _repin() async {
    if (_selectedIndex == null) return;
    await _pushToWidget(_selectedIndex!);
    final supported =
        await HomeWidget.isRequestPinWidgetSupported() ?? false;
    if (supported) {
      await HomeWidget.requestPinWidget(
        androidName: 'FavoritoWidgetProvider',
      );
    }
    if (mounted) {
      setState(() => _widgetMissing = false);
      if (!supported) _showManualPinDialog();
    }
  }

  void _showManualPinDialog() {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Añadir widget'),
        content: const Text(
          'Mantén presionado un espacio vacío en la pantalla de inicio, '
          'selecciona "Widgets", busca "VIDA" y arrastra "Widget favorito" '
          'a tu pantalla.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Entendido'),
          ),
        ],
      ),
    );
  }

  FavVerse? get _selectedVerse =>
      _selectedIndex != null ? favVerses[_selectedIndex!] : null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Widget favorito')),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(20),
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Widget activo',
                                style: GoogleFonts.dmSans(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.emerald900,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Muestra un versículo en la pantalla de inicio',
                                style: GoogleFonts.dmSans(
                                  fontSize: 13,
                                  color: AppColors.emerald600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        Switch(
                          value: _enabled,
                          activeTrackColor: AppColors.emerald200,
                          activeThumbColor: AppColors.emerald600,
                          onChanged: _toggle,
                        ),
                      ],
                    ),
                  ),
                ),
                if (_widgetMissing) ...[
                  const SizedBox(height: 12),
                  _warningBanner(),
                ],
                if (_enabled && _selectedVerse != null) ...[
                  const SizedBox(height: 24),
                  _previewCard(),
                ],
                const SizedBox(height: 24),
                Text(
                  'ELIGE UN VERSÍCULO',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald600,
                  ),
                ),
                const SizedBox(height: 8),
                ...List.generate(favVerses.length, (i) {
                  final verse = favVerses[i];
                  final selected = _selectedIndex == i;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Material(
                      color: selected
                          ? AppColors.emerald100
                          : AppColors.emerald50,
                      borderRadius: BorderRadius.circular(12),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: _enabled ? () => _selectVerse(i) : null,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 12),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      verse.referencia,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.emerald900,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      verse.versiculo,
                                      style: GoogleFonts.dmSans(
                                        fontSize: 12,
                                        color: AppColors.emerald700,
                                        height: 1.3,
                                      ),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              if (selected)
                                const Icon(Icons.check_circle_rounded,
                                    color: AppColors.emerald600, size: 22),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
                const SizedBox(height: 16),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.emerald50,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.emerald200),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.info_outline_rounded,
                          size: 18, color: AppColors.emerald500),
                      const SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          'Selecciona un versículo de la lista y aparecerá en el widget. Puedes cambiarlo cuando quieras.',
                          style: GoogleFonts.dmSans(
                            fontSize: 12,
                            height: 1.4,
                            color: AppColors.emerald700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _warningBanner() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.emerald50,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.amber400, width: 1.5),
      ),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded,
              color: AppColors.amber400, size: 22),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Widget eliminado',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald900,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'El widget ya no está en tu pantalla de inicio.',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: AppColors.emerald700,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          FilledButton.tonalIcon(
            onPressed: _repin,
            icon: const Icon(Icons.add_circle_outline_rounded, size: 18),
            label: const Text('Añadir'),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.emerald600,
              foregroundColor: Colors.white,
              padding:
                  const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _previewCard() {
    final v = _selectedVerse!;
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'widget-fav.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(color: Colors.white.withValues(alpha: 0.69)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '"${v.versiculo}"',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 18,
                        color: Colors.black87,
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      v.referencia,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
