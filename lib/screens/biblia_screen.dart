import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/app_theme.dart';

class BibliaScreen extends StatefulWidget {
  final VoidCallback? onGoHome;
  const BibliaScreen({super.key, this.onGoHome});

  @override
  State<BibliaScreen> createState() => _BibliaScreenState();
}

class _BibliaScreenState extends State<BibliaScreen> {
  bool _checking = true;
  bool _hasInternet = false;
  StreamSubscription? _subscription;

  @override
  void initState() {
    super.initState();
    _checkConnectivity();
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  Future<void> _checkConnectivity() async {
    final result = await Connectivity().checkConnectivity();
    _hasInternet = result.isNotEmpty && !result.contains(ConnectivityResult.none);
    if (mounted) setState(() => _checking = false);

    _subscription = Connectivity().onConnectivityChanged.listen((r) {
      if (!mounted) return;
      setState(() => _hasInternet = r.isNotEmpty && !r.contains(ConnectivityResult.none));
    });
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
                  const Text(
                    'Sin conexión',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: AppColors.emerald800,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'No tienes internet en este momento',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 15, color: AppColors.emerald600),
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    'Pero recuerda:\n"Dios está con nosotros siempre"\n(Mateo 28:20)',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      color: AppColors.emerald700,
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
                      textStyle: const TextStyle(
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

    final controller = WebViewController();
    controller.setJavaScriptMode(JavaScriptMode.unrestricted);
    controller.setNavigationDelegate(
      NavigationDelegate(
        onPageFinished: (_) {
          controller.runJavaScript('''
            (function(){
              document.documentElement.style.zoom = '100%';
              var s = document.createElement('style');
              s.textContent = 'body{overflow-x:hidden!important;max-width:100vw!important}html{overflow-x:hidden!important}';
              document.head.appendChild(s);
            })();
          ''');
        },
      ),
    );
    controller.setUserAgent(
      'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 '
      '(KHTML, like Gecko) Chrome/125.0.0.0 Safari/537.36',
    );
    controller.loadRequest(
      Uri.parse('https://www.bible.com/bible/149/JHN.1.RVR1960'),
    );

    return Scaffold(
      body: SafeArea(child: WebViewWidget(controller: controller)),
    );
  }
}
