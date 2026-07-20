import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../theme/app_theme.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  late final WebViewController _controller;
  var _loading = true;
  var _error = false;

  @override
  void initState() {
    super.initState();
    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageFinished: (_) {
            if (mounted) setState(() => _loading = false);
          },
          onWebResourceError: (e) {
            if ((e.isForMainFrame ?? true) && mounted) setState(() => _error = true);
          },
        ),
      );
    _loadLocalHtml();
  }

  Future<void> _loadLocalHtml() async {
    try {
      final html = await DefaultAssetBundle.of(context)
          .loadString('games/quiz/index.html');
      await _controller.loadHtmlString(html);
    } catch (_) {
      if (mounted) setState(() => _error = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz Bíblico'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              if (_loading)
                LinearProgressIndicator(
                  color: AppColors.emerald600,
                  backgroundColor: AppColors.emerald100,
                ),
              Expanded(child: WebViewWidget(controller: _controller)),
            ],
          ),
          if (_error)
            Container(
              color: Theme.of(context).colorScheme.surface,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.bug_report_rounded,
                          size: 48, color: AppColors.emerald400),
                      const SizedBox(height: 16),
                      Text(
                        'No se pudo cargar el juego',
                        style: TextStyle(
                            fontFamily: 'DM Sans',
                            fontSize: 16,
                            color: AppColors.emerald700),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton.icon(
                        onPressed: () {
                          setState(() {
                            _error = false;
                            _loading = true;
                          });
                          _loadLocalHtml();
                        },
                        icon: Icon(Icons.refresh_rounded),
                        label: const Text('Reintentar'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
