import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../main.dart';
import '../theme/app_theme.dart';

class PerfilScreen extends StatelessWidget {
  const PerfilScreen({super.key});

  void _openUrl(String url) {
    launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final userName = VidaApp.of(context).userName;
    final initial = userName.isNotEmpty ? userName[0].toUpperCase() : '?';

    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.emerald200),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 24,
                    backgroundColor: cs.primary,
                    child: Text(
                      initial,
                      style: TextStyle(fontFamily: 'DM Sans', 
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Text(
                    userName,
                    style: TextStyle(fontFamily: 'DM Sans', 
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald900,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [
                    AppColors.emerald600,
                    AppColors.emerald700,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.eco_rounded,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        'TU VERSÍCULO VIDA',
                        style: TextStyle(fontFamily: 'DM Sans', 
                          fontSize: 10,
                          letterSpacing: 2,
                          fontWeight: FontWeight.w500,
                          color: Colors.white.withValues(alpha: 0.55),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 14),
                  Text(
                    'Próximamente',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontFamily: 'Cormorant Garamond', 
                      fontSize: 22,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Un versículo único para ti',
                    style: TextStyle(fontFamily: 'DM Sans', 
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                border: Border.all(color: AppColors.emerald200, width: 1),
              ),
              child: InkWell(
                borderRadius: BorderRadius.circular(18),
                onTap: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      'Donar',
                      style: TextStyle(fontFamily: 'DM Sans', 
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald800,
                      ),
                    ),
                    content: Text(
                      'Gracias por tu interés en donar. '
                      'Actualmente no contamos con métodos de donación '
                      'disponibles, pero pronto los habilitaremos. '
                      '¡Vuelve más tarde!',
                      style: TextStyle(fontFamily: 'DM Sans', 
                        fontSize: 14,
                        height: 1.5,
                        color: AppColors.emerald700,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(ctx),
                        child: Text(
                          'Entendido',
                          style: TextStyle(fontFamily: 'DM Sans', 
                            fontWeight: FontWeight.w600,
                            color: AppColors.emerald600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(18),
                  child: Row(
                    children: [
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          color: AppColors.emerald100,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Icon(
                          Icons.favorite_rounded,
                          color: AppColors.emerald600,
                          size: 22,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Donar',
                              style: TextStyle(fontFamily: 'DM Sans', 
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.emerald900,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              'Apoya este proyecto',
                              style: TextStyle(fontFamily: 'DM Sans', 
                                fontSize: 12,
                                color: AppColors.emerald600,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(
                        Icons.chevron_right_rounded,
                        color: AppColors.emerald400,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 28),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'CRÉDITOS',
                style: TextStyle(fontFamily: 'DM Sans', 
                  fontSize: 10,
                  letterSpacing: 2,
                  fontWeight: FontWeight.w600,
                  color: AppColors.emerald600,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _creditLine(
                      'Desarrollado por',
                      'Ángel Salinas Pérez',
                      Icons.code_rounded,
                      onTap: () =>
                          _openUrl('https://github.com/AngelDev2343'),
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Diseño',
                      'VIDA App',
                      Icons.palette_rounded,
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Biblia',
                      'YouVersion',
                      Icons.menu_book_rounded,
                      onTap: () => _openUrl('https://www.bible.com'),
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Versión',
                      '0.5 (Build)',
                      Icons.info_outline_rounded,
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

  Widget _creditLine(
    String label,
    String value,
    IconData icon, {
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Icon(icon, size: 18, color: AppColors.emerald500),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: TextStyle(fontFamily: 'DM Sans', 
                      fontSize: 11,
                      color: AppColors.emerald500,
                    ),
                  ),
                  Row(
                    children: [
                      Text(
                        value,
                        style: TextStyle(fontFamily: 'DM Sans', 
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.emerald900,
                        ),
                      ),
                      if (onTap != null) ...[
                        const SizedBox(width: 6),
                        const Icon(
                          Icons.open_in_new_rounded,
                          size: 12,
                          color: AppColors.emerald400,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
