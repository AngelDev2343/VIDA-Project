import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:home_widget/home_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data/streak.dart';
import 'services/notification_service.dart';
import 'theme/app_theme.dart';
import 'screens/biblia_screen.dart';
import 'screens/home_screen.dart';
import 'screens/perfil_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/vida_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await NotificationService.init();
  NotificationService.requestPermission();
  HomeWidget.setAppGroupId('group.com.vida.project');
  runApp(const VidaApp());
}

class VidaApp extends StatefulWidget {
  const VidaApp({super.key});

  // ignore: library_private_types_in_public_api
  static _VidaAppState of(BuildContext context) =>
      context.findAncestorStateOfType<_VidaAppState>()!;

  @override
  State<VidaApp> createState() => _VidaAppState();
}

class _VidaAppState extends State<VidaApp> {
  bool _ready = false;
  String _userName = '';

  String get userName => _userName;

  @override
  void initState() {
    super.initState();
    _loadUser();
  }

  Future<void> _loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    _userName = prefs.getString('user_name') ?? '';

    final daysAway = await NotificationService.daysSinceLastOpen();
    if (daysAway >= 2 && await NotificationService.shouldShowToday()) {
      NotificationService.showMotivational();
    }

    await StreakService.checkAndUpdate();

    if (prefs.containsKey('contra_pecado')) {
      try {
        await HomeWidget.saveWidgetData(
            'contra_pecado', prefs.getBool('contra_pecado'));
        await HomeWidget.updateWidget(
          androidName: 'ContraPecadoWidgetProvider',
          iOSName: 'ContraPecadoWidget',
        );
      } catch (_) {}
    }

    if (prefs.containsKey('favorito')) {
      try {
        await HomeWidget.saveWidgetData(
            'favorito', prefs.getBool('favorito'));
        await HomeWidget.updateWidget(
          androidName: 'FavoritoWidgetProvider',
          iOSName: 'FavoritoWidget',
        );
      } catch (_) {}
    }

    final firstPin = prefs.getBool('first_launch_pin') ?? false;
    if (!firstPin) {
      await prefs.setBool('first_launch_pin', true);
      HomeWidget.isRequestPinWidgetSupported().then((s) {
        if (s == true) HomeWidget.requestPinWidget(androidName: 'ContraPecadoWidgetProvider');
      });
    }
    setState(() => _ready = true);
  }

  void setUserName(String name) {
    setState(() => _userName = name);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VIDA',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      home: _buildHome(),
    );
  }

  Widget _buildHome() {
    if (!_ready) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    if (_userName.isEmpty) {
      return const SplashScreen();
    }
    return const AppShell();
  }
}

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _selectedIndex = 0;

  Future<void> _onTabSelected(int i) async {
    if (i == 2) {
      final prefs = await SharedPreferences.getInstance();
      final shown = prefs.getBool('vida_intro_shown') ?? false;
      if (!shown) {
        await prefs.setBool('vida_intro_shown', true);
        if (!mounted) return;
        await showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            title: Row(
              children: [
                const Icon(Icons.eco_rounded,
                    color: AppColors.emerald600, size: 24),
                const SizedBox(width: 8),
                Text('VIDA',
                    style: GoogleFonts.cormorantGaramond(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald800)),
              ],
            ),
            content: Text(
              'VIDA no es solo una app, sino un algoritmo que aprende de ti. '
              'Con cada interacción —lecturas, estudios, oraciones— detecta '
              'tu momento espiritual y te asigna un versículo '
              'personalizado, justo para lo que necesitas.',
              style: GoogleFonts.dmSans(
                  fontSize: 14,
                  height: 1.5,
                  color: AppColors.emerald700),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx),
                child: Text('Entendido',
                    style: GoogleFonts.dmSans(
                        fontWeight: FontWeight.w600,
                        color: AppColors.emerald600)),
              ),
            ],
          ),
        );
      }
    }
    if (mounted) setState(() => _selectedIndex = i);
  }

  @override
  Widget build(BuildContext context) {
    final pages = <Widget>[
      const HomeScreen(),
      BibliaScreen(
        isActive: _selectedIndex == 1,
        onGoHome: () => setState(() => _selectedIndex = 0),
      ),
      const VidaScreen(),
      const PerfilScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: pages,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(color: AppColors.emerald200, width: 1),
          ),
        ),
        child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: _onTabSelected,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home_rounded),
            label: 'Inicio',
          ),
          NavigationDestination(
            icon: Icon(Icons.book_outlined),
            selectedIcon: Icon(Icons.book_rounded),
            label: 'Biblia',
          ),
          NavigationDestination(
            icon: Icon(Icons.eco_outlined),
            selectedIcon: Icon(Icons.eco_rounded),
            label: 'VIDA',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded),
            label: 'Perfil',
          ),
        ],
      ),
        ),
    );
  }
}
