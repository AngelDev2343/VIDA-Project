import 'package:flutter/material.dart';
import '../data/vida_signals.dart';
import '../theme/app_theme.dart';
import '../theme/transitions.dart';
import 'arcade_games.dart';
import 'quiz_screen.dart';
import 'riega_screen.dart';

class MiniArcadeScreen extends StatelessWidget {
  const MiniArcadeScreen({super.key});

  static const _games = [
    _GameData(
      icon: Icons.quiz_rounded,
      title: 'Quiz',
      subtitle: 'Preguntas bíblicas',
    ),
    _GameData(
      icon: Icons.grass_rounded,
      title: 'Riega y crece',
      subtitle: 'Cultiva tu fe',
    ),
    _GameData(
      icon: Icons.grid_view_rounded,
      title: 'Memorama',
      subtitle: 'Empareja versículos',
    ),
    _GameData(
      icon: Icons.sort_by_alpha_rounded,
      title: 'Ordena el versículo',
      subtitle: 'Palabras mezcladas',
    ),
    _GameData(
      icon: Icons.rule_rounded,
      title: 'Verdadero / Falso',
      subtitle: 'Pon a prueba lo que sabes',
    ),
    _GameData(
      icon: Icons.category_rounded,
      title: 'Trivia',
      subtitle: 'Por categorías',
    ),
    _GameData(
      icon: Icons.hiking_rounded,
      title: 'Camino del discípulo',
      subtitle: 'Elige con sabiduría',
    ),
    _GameData(
      icon: Icons.record_voice_over_rounded,
      title: '¿Quién lo dijo?',
      subtitle: 'Citas y personajes',
    ),
  ];

  void _open(BuildContext context, int i) {
    VidaSignals.trackEvent('arcade');
    final Widget page = switch (i) {
      0 => const QuizScreen(),
      1 => const RiegaScreen(),
      2 => const MemoramaScreen(),
      3 => const OrdenaVersiculoScreen(),
      4 => const VerdaderoFalsoScreen(),
      5 => const TriviaCategoriasScreen(),
      6 => const CaminoDiscipuloScreen(),
      _ => const QuienLoDijoScreen(),
    };
    Navigator.push(context, slideUpRoute(page));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Arcade')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 0.85,
          ),
          itemCount: _games.length,
          itemBuilder: (_, i) => _GameCard(
            data: _games[i],
            onTap: () => _open(context, i),
          ),
        ),
      ),
    );
  }
}

class _GameData {
  final IconData icon;
  final String title;
  final String subtitle;
  const _GameData({
    required this.icon,
    required this.title,
    required this.subtitle,
  });
}

class _GameCard extends StatelessWidget {
  final _GameData data;
  final VoidCallback onTap;
  const _GameCard({required this.data, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: AppColors.emerald200, width: 1),
          boxShadow: [
            BoxShadow(
              color: AppColors.emerald900.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.emerald100,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(data.icon, color: AppColors.emerald700),
            ),
            const Spacer(),
            Text(
              data.title,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.emerald900,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              data.subtitle,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontSize: 12,
                color: AppColors.emerald600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
