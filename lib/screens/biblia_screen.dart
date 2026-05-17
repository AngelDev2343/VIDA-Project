import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/app_theme.dart';

class BibliaScreen extends StatefulWidget {
  final bool isActive;
  final VoidCallback? onGoHome;
  const BibliaScreen({super.key, required this.isActive, this.onGoHome});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  final _connectivity = Connectivity();

  bool _checking = true;
  bool _hasInternet = false;
  int _loadingProgress = 0;
  bool _loadError = false;
  StreamSubscription? _subscription;
  WebViewController? _controller;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void didUpdateWidget(BibliaScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isActive && !oldWidget.isActive) {
      _loadError = false;
      _initController();
    } else if (!widget.isActive && oldWidget.isActive) {
      _disposeController();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _controller = null;
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final result = await _connectivity.checkConnectivity();
    _hasInternet = result.isNotEmpty && !result.contains(ConnectivityResult.none);
    if (mounted) {
      setState(() => _checking = false);
      if (widget.isActive && _hasInternet) _initController();
    }

    _subscription = _connectivity.onConnectivityChanged.listen((r) {
      if (!mounted) return;
      final online = r.isNotEmpty && !r.contains(ConnectivityResult.none);
      if (online && !_hasInternet) {
        _loadError = false;
        _initController();
      }
      setState(() => _hasInternet = online);
    });
  }

  void _initController() {
    if (_controller != null || !_hasInternet) return;
    final c = WebViewController();
    c.setJavaScriptMode(JavaScriptMode.unrestricted);
    c.setNavigationDelegate(
      NavigationDelegate(
        onProgress: (progress) {
          if (mounted) setState(() => _loadingProgress = progress);
        },
        onPageFinished: (_) {
          if (mounted) setState(() => _loadingProgress = 100);
          c.runJavaScript('''
            (function(){
              var s = document.createElement('style');
              s.textContent = 'body{overflow-x:hidden!important;max-width:100vw!important}html{overflow-x:hidden!important}';
              document.head.appendChild(s);
            })();
          ''');
        },
        onWebResourceError: (e) {
          if ((e.isForMainFrame ?? true) && mounted) setState(() => _loadError = true);
        },
      ),
    );
    c.setUserAgent(
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    );
    c.loadRequest(
      Uri.parse('https://www.bible.com/bible/149/JHN.1.RVR1960'),
    );
    setState(() => _controller = c);
  }

  void _disposeController() {
    _controller = null;
    _loadingProgress = 0;
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_checking) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (!_hasInternet) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off_rounded, size: 64, color: AppColors.emerald300),
                  const SizedBox(height: 20),
                  Text(
                    'Sin conexión',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No tienes internet en este momento',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.emerald600),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Pero recuerda:',
                    style: GoogleFonts.dmSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.emerald600,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    '«Dios está con nosotros siempre»',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: 'serif',
                      fontSize: 19,
                      height: 1.4,
                      fontStyle: FontStyle.italic,
                      color: AppColors.emerald800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Mateo 28:20',
                    style: GoogleFonts.dmSans(
                      fontSize: 11,
                      letterSpacing: 1.5,
                      fontWeight: FontWeight.w500,
                      color: AppColors.emerald500,
                    ),
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: widget.onGoHome,
                    icon: const Icon(Icons.home_rounded),
                    label: const Text('Volver a inicio'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.emerald600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                      textStyle: GoogleFonts.dmSans(
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_controller == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    if (_loadError) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.error_outline_rounded, size: 64, color: AppColors.emerald300),
                  const SizedBox(height: 20),
                  Text(
                    'Error al cargar',
                    style: GoogleFonts.dmSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'No se pudo cargar la Biblia',
                    textAlign: TextAlign.center,
                    style: GoogleFonts.dmSans(fontSize: 15, color: AppColors.emerald600),
                  ),
                  const SizedBox(height: 32),
                  FilledButton.icon(
                    onPressed: () {
                      setState(() => _loadError = false);
                      _initController();
                    },
                    icon: const Icon(Icons.refresh_rounded),
                    label: const Text('Reintentar'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppColors.emerald600,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                      textStyle: GoogleFonts.dmSans(fontSize: 15, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }

    if (_loadingProgress < 100) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(
                  width: 28,
                  height: 28,
                  child: CircularProgressIndicator(
                    strokeWidth: 2.5,
                    color: AppColors.emerald600,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Cargando',
                  style: GoogleFonts.dmSans(
                    fontSize: 14,
                    color: AppColors.emerald600,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: _controller!)),
    );
  }
}
