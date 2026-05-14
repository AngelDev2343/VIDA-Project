import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'screens/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
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

  final List<Widget> _pages = const [
    HomeScreen(),
    _PlaceholderScreen(label: 'Biblia'),
    _PlaceholderScreen(label: 'VIDA'),
    _PlaceholderScreen(label: 'Perfil'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: _pages,
      ),
      bottomNavigationBar: NavigationBarTheme(
        data: NavigationBarThemeData(
          iconTheme: WidgetStateProperty.resolveWith((states) {
            if (states.contains(WidgetState.selected)) {
              return const IconThemeData(color: AppColors.emerald700);
            }
            return const IconThemeData(color: AppColors.emerald400);
          }),
        ),
        child: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (i) => setState(() => _selectedIndex = i),
        backgroundColor: Colors.white,
        indicatorColor: AppColors.emerald100,
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

class _PlaceholderScreen extends StatelessWidget {
  final String label;
  const _PlaceholderScreen({required this.label});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.construction_rounded, size: 48, color: cs.primary),
            const SizedBox(height: 12),
            Text(
              label,
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w500,
                color: cs.onSurface,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              'En construcción',
              style: TextStyle(fontSize: 14, color: cs.outline),
            ),
          ],
        ),
      ),
    );
  }
}