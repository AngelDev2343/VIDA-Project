import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/vida_algorithm.dart';
import '../main.dart';
import '../theme/app_theme.dart';
import 'appearance_screen.dart';

class PerfilScreen extends StatefulWidget {
  const PerfilScreen({super.key});

  @override
  State<PerfilScreen> createState() => _PerfilScreenState();
}

class _PerfilScreenState extends State<PerfilScreen> {
  VidaAssignment? _vida;

  @override
  void initState() {
    super.initState();
    _load();
    VidaAlgorithm.assignmentChanges.addListener(_load);
  }

  @override
  void dispose() {
    VidaAlgorithm.assignmentChanges.removeListener(_load);
    super.dispose();
  }

  Future<void> _load() async {
    final a = await VidaAlgorithm.current();
    if (!mounted) return;
    setState(() => _vida = a);
  }

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
                color: Theme.of(context).colorScheme.surfaceContainerLow,
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
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Text(
                      userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald900,
                      ),
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
                gradient: LinearGradient(
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
                      Icon(Icons.eco_rounded,
                          size: 16, color: Colors.white70),
                      const SizedBox(width: 6),
                      Text(
                        'TU VERSÍCULO VIDA',
                        style: TextStyle(
                          fontFamily: 'DM Sans',
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
                    _vida == null
                        ? 'Aún no descubierto'
                        : '"${_vida!.text}"',
                    textAlign: TextAlign.center,
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontFamily: 'Cormorant Garamond',
                      fontSize: 20,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    _vida?.reference ?? 'Ve a la pestaña VIDA',
                    style: TextStyle(
                      fontFamily: 'DM Sans',
                      fontSize: 12,
                      color: Colors.white.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.palette_rounded, color: AppColors.emerald600),
                title: Text(
                  'Apariencia',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald900,
                  ),
                ),
                subtitle: Text(
                  'Tema, modo claro/oscuro y color de acento',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 12,
                    color: AppColors.emerald600,
                  ),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    color: AppColors.emerald400),
                onTap: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AppearanceScreen()),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Card(
              child: ListTile(
                leading: Icon(Icons.favorite_rounded, color: AppColors.emerald600),
                title: Text(
                  'Donar',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald900,
                  ),
                ),
                subtitle: Text(
                  'Apoya este proyecto',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontSize: 12,
                    color: AppColors.emerald600,
                  ),
                ),
                trailing: Icon(Icons.chevron_right_rounded,
                    color: AppColors.emerald400),
                onTap: () => showDialog(
                  context: context,
                  builder: (ctx) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    title: Text(
                      'Donar',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald800,
                      ),
                    ),
                    content: Text(
                      'Gracias por tu interés en donar. '
                      'Actualmente no contamos con métodos de donación '
                      'disponibles, pero pronto los habilitaremos. '
                      '¡Vuelve más tarde!',
                      style: TextStyle(
                        fontFamily: 'DM Sans',
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
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontWeight: FontWeight.w600,
                            color: AppColors.emerald600,
                          ),
                        ),
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
                      'WDG Technologies',
                      Icons.code_rounded,
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
                      'Reina-Valera 1909 (dominio público)',
                      Icons.menu_book_rounded,
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Evangelízate',
                      'Ray Comfort (Living Waters), Billy Graham, '
                      'Greg Laurie (Harvest), Camino de Romanos',
                      Icons.campaign_outlined,
                      onTap: () => _openUrl(
                        'https://livingwaters.com/how-to-effectively-share-the-gospel/',
                      ),
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Ayuda de',
                      'Leonardo López',
                      Icons.handshake_rounded,
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Versión',
                      '0.7 (Beta)',
                      Icons.info_outline_rounded,
                    ),
                    const Divider(height: 24),
                    _creditLine(
                      'Mapas',
                      '© OpenStreetMap contributors',
                      Icons.map_rounded,
                      onTap: () => _openUrl(
                          'https://www.openstreetmap.org/copyright'),
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
                      Expanded(
                        child: Text(
                          value,
                          softWrap: true,
                          style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: AppColors.emerald900,
                          ),
                        ),
                      ),
                      if (onTap != null) ...[
                        const SizedBox(width: 6),
                        Icon(
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
