import 'package:flutter/material.dart';
import '../data/evangelizate_data.dart';
import '../theme/app_theme.dart';
import '../widgets/fade_in.dart';
import '../widgets/tool_card.dart';
import 'evangelizate_detalle_screen.dart';

class EvangelizateScreen extends StatelessWidget {
  const EvangelizateScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Evangelízate')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FadeIn(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: AppColors.emerald50,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.emerald200),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.auto_awesome_rounded,
                            size: 20, color: AppColors.emerald600),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tips para la Evangelización',
                            style: TextStyle(fontFamily: 'DM Sans',
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.emerald800,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Cuando evangelizamos, muchas veces no sabemos qué decir. '
                      'Aquí encontrarás algunos tips para iniciar conversaciones '
                      'que puedan llevar al evangelio de nuestro Señor Jesucristo.',
                      style: TextStyle(fontFamily: 'DM Sans',
                        fontSize: 13,
                        height: 1.5,
                        color: AppColors.emerald700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.emerald200),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.format_quote_rounded,
                              size: 20, color: AppColors.emerald500),
                          const SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              '"Si murieras hoy, ¿a dónde crees que irías: '
                              'al cielo o al infierno?"',
                              style: TextStyle(fontFamily: 'Cormorant Garamond',
                                fontSize: 17,
                                fontWeight: FontWeight.w600,
                                height: 1.3,
                                color: AppColors.emerald900,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            FadeIn(
              index: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 4, bottom: 10),
                child: Text(
                  'RESPUESTAS COMUNES',
                  style: TextStyle(fontFamily: 'DM Sans',
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w600,
                    color: AppColors.emerald600,
                  ),
                ),
              ),
            ),
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 0.85,
              children: List.generate(
                evangelizateCategories.length,
                (i) => FadeIn(
                  index: i + 2,
                  child: ToolCard(
                    icon: evangelizateCategories[i].icon,
                    title: evangelizateCategories[i].shortTitle,
                    subtitle: evangelizateCategories[i].description,
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => EvangelizateDetalleScreen(
                          category: evangelizateCategories[i],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
