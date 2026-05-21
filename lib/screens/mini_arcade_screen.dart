import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../theme/transitions.dart';
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
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mini Arcade')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 0.85,
          children: [
            _GameCard(
              data: _games[0],
              onTap: () =>
                  Navigator.push(context, slideUpRoute(const QuizScreen())),
            ),
            _GameCard(
              data: _games[1],
              onTap: () =>
                  Navigator.push(context, slideUpRoute(const RiegaScreen())),
            ),
          ],
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
          color: Colors.white,
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
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.emerald100,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(data.icon, size: 24, color: AppColors.emerald600),
              ),
              const SizedBox(height: 12),
              Text(
                data.title,
                style: TextStyle(fontFamily: 'DM Sans', 
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: AppColors.emerald900,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                data.subtitle,
                style: TextStyle(fontFamily: 'DM Sans', 
                  fontSize: 11,
                  color: AppColors.emerald600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
