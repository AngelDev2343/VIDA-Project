import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../main.dart';
import '../theme/app_theme.dart';
import '../widgets/vida_verse_card.dart';
import '../widgets/tool_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final userName = VidaApp.of(context).userName;

    const sectionLabelColor = AppColors.emerald600;
    const headerSubColor = AppColors.emerald700;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.only(bottom: 24),
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
                          color: headerSubColor,
                        ),
                      ),
                    ],
                  ),
                  const Spacer(),
                  const Icon(Icons.notifications_none_rounded,
                      size: 24,
                      color: headerSubColor),
                  const SizedBox(width: 12),
                  CircleAvatar(
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
                ],
              ),
            ),

            const SizedBox(height: 8),

            VidaVerseCard(
              verseText:
                  'Porque yo sé los planes que tengo para vosotros, planes de bienestar y no de calamidad...',
              reference: 'Jeremías 29:11',
              onShare: () {},
              onSave: () {},
            ),

            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GestureDetector(
                onTap: () {},
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
                          Text(
                            '14',
                            style: GoogleFonts.dmSans(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: AppColors.emerald900,
                              height: 1,
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
                              '14 días de racha',
                              style: GoogleFonts.dmSans(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.emerald900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Tu mejor racha: 21 días',
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

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'HERRAMIENTAS',
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: sectionLabelColor,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 1.25,
                children: [
                  ToolCard(
                    icon: Icons.shield_rounded,
                    title: 'Contra el pecado',
                    subtitle: 'Recuerdos y alertas',
                    onTap: () {},
                  ),
                  ToolCard(
                    icon: Icons.menu_book_rounded,
                    title: 'Estudio bíblico',
                    subtitle: 'Explorar la Palabra',
                    onTap: () {},
                  ),
                  ToolCard(
                    icon: Icons.support_rounded,
                    title: 'Situación difícil',
                    subtitle: 'Versículos de ayuda',
                    onTap: () {},
                  ),
                  ToolCard(
                    icon: Icons.add_photo_alternate_rounded,
                    title: 'Crear imagen',
                    subtitle: 'Para compartir',
                    onTap: () {},
                  ),
                  ToolCard(
                    icon: Icons.star_border_rounded,
                    title: 'Widget favorito',
                    subtitle: 'Versículo personalizado',
                    onTap: () {},
                  ),
                  ToolCard(
                    icon: Icons.music_note_rounded,
                    title: 'Canciones',
                    subtitle: 'Música cristiana',
                    onTap: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
              child: Text(
                'MINI ARCADE',
                style: GoogleFonts.dmSans(
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: sectionLabelColor,
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 18, vertical: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: AppColors.emerald300,
                    width: 1.5,
                    style: BorderStyle.solid,
                  ),
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
                            'Próximamente · En desarrollo',
                            style: GoogleFonts.dmSans(
                              fontSize: 12,
                              color: headerSubColor,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.lock_outline_rounded,
                        size: 18, color: sectionLabelColor),
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