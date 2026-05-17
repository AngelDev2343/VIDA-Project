import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/streak.dart';
import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/vida_verse_card.dart';
import '../widgets/tool_card.dart';
import '../widgets/fade_in.dart';
import 'contra_pecado_screen.dart';
import 'estudio_biblico_screen.dart';
import 'favorito_screen.dart';
import 'gallery_screen.dart';
import 'streak_screen.dart';
import 'mini_arcade_screen.dart';
import 'perfil_screen.dart';
import 'situacion_dificil_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _contraPecadoEnabled = false;
  bool _favoritoEnabled = false;
  int _streak = 0;
  int _bestStreak = 0;

  @override
  void initState() {
    super.initState();
    _loadContraPecado();
    _loadFavorito();
    _loadStreak();
  }

  Future<void> _loadContraPecado() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () => _contraPecadoEnabled = prefs.getBool('contra_pecado') ?? false,
    );
  }

  Future<void> _loadFavorito() async {
    final prefs = await SharedPreferences.getInstance();
    setState(
      () => _favoritoEnabled = prefs.getBool('favorito') ?? false,
    );
  }



  Future<void> _loadStreak() async {
    final count = await StreakService.getCount();
    final best = await StreakService.getBest();
    setState(() {
      _streak = count;
      _bestStreak = best;
    });
  }

  Widget _sectionLabel(String text) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: Text(
        text,
        style: GoogleFonts.dmSans(
          fontSize: 10,
          letterSpacing: 2,
          fontWeight: FontWeight.w600,
          color: AppColors.emerald600,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final userName = VidaApp.of(context).userName;

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 24),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 12, 20, 6),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'VIDA',
                        style: GoogleFonts.cormorantGaramond(
                          fontSize: 32,
                          fontWeight: FontWeight.w600,
                          color: cs.primary,
                          letterSpacing: -0.5,
                        ),
                      ),
                      Text(
                        'Buenos días, $userName',
                        style: GoogleFonts.dmSans(
                          fontSize: 12,
                          color: AppColors.emerald700,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const PerfilScreen()),
                    ),
                    child: CircleAvatar(
                      radius: 19,
                      backgroundColor: cs.primary,
                      child: Text(
                        userName.isNotEmpty ? userName[0].toUpperCase() : '?',
                        style: GoogleFonts.dmSans(
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            FadeIn(
              child: VidaVerseCard(
                verseText: 'Próximamente',
                reference: 'Tu versículo VIDA',
                onShare: () {},
                onSave: () {},
              ),
            ),

            const SizedBox(height: 12),

            FadeIn(
              index: 1,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () async {
                    await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const StreakScreen()),
                    );
                    _loadStreak();
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 14),
                    decoration: BoxDecoration(
                      color: AppColors.emerald100,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Row(
                      children: [
                        Column(
                          children: [
                            const Icon(Icons.local_fire_department_rounded,
                                size: 30, color: AppColors.amber400),
                            const SizedBox(height: 2),
                            TweenAnimationBuilder<int>(
                              tween: IntTween(begin: 0, end: _streak),
                              duration: const Duration(milliseconds: 400),
                              builder: (_, v, __) => Text(
                                '$v',
                                style: GoogleFonts.dmSans(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.emerald900,
                                  height: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '$_streak días de racha',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.emerald900,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'Tu mejor racha: $_bestStreak días',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: AppColors.emerald600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            color: AppColors.emerald500),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            FadeIn(
              index: 2,
              child: _sectionLabel('HERRAMIENTAS'),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 0.85,
                children: [
                  FadeIn(
                    index: 3,
                    child: ToolCard(
                      icon: Icons.shield_rounded,
                      title: 'Contra pecado',
                      subtitle: 'Recuerdos y alertas',
                      isActive: _contraPecadoEnabled,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ContraPecadoScreen()),
                        );
                        _loadContraPecado();
                      },
                    ),
                  ),
                  FadeIn(
                    index: 4,
                    child: ToolCard(
                      icon: Icons.menu_book_rounded,
                      title: 'Estudio bíblico',
                      subtitle: 'Explorar la Palabra',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const EstudioBiblicoScreen()),
                      ),
                    ),
                  ),
                  FadeIn(
                    index: 5,
                    child: ToolCard(
                      icon: Icons.support_rounded,
                      title: 'Situación difícil',
                      subtitle: 'Versículos de ayuda',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const SituacionDificilScreen()),
                      ),
                    ),
                  ),
                  FadeIn(
                    index: 6,
                    child: ToolCard(
                      icon: Icons.add_photo_alternate_rounded,
                      title: 'Crear imagen',
                      subtitle: 'Para compartir',
                      onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GalleryScreen()),
                      ),
                    ),
                  ),
                  FadeIn(
                    index: 7,
                    child: ToolCard(
                      icon: Icons.star_border_rounded,
                      title: 'Widget favorito',
                      subtitle: 'Versículo personalizado',
                      isActive: _favoritoEnabled,
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const FavoritoScreen()),
                        );
                        _loadFavorito();
                      },
                    ),
                  ),
                  FadeIn(
                    index: 8,
                    child: ToolCard(
                      icon: Icons.volunteer_activism_rounded,
                      title: 'Evangelízate',
                      subtitle: 'Guía de evangelización',
                      onTap: () {},
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            FadeIn(
              index: 9,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const MiniArcadeScreen()),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 18, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: AppColors.emerald300,
                        width: 1.5,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.emerald900.withValues(alpha: 0.04),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.sports_esports_rounded,
                            size: 30, color: cs.primary),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Mini Arcade',
                                style: GoogleFonts.dmSans(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: cs.onSurface,
                                ),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '2 juegos disponibles',
                                style: GoogleFonts.dmSans(
                                  fontSize: 12,
                                  color: AppColors.emerald600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right_rounded,
                            size: 18, color: AppColors.emerald500),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
