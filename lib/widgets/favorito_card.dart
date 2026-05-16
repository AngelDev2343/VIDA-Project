import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritoCard extends StatelessWidget {
  final String referencia;
  final String versiculo;

  const FavoritoCard({
    super.key,
    required this.referencia,
    required this.versiculo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(18),
      child: SizedBox(
        width: double.infinity,
        height: 200,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'widget-fav.png',
                fit: BoxFit.cover,
              ),
            ),
            Container(color: Colors.white.withValues(alpha: 0.69)),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20, vertical: 24),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '"$versiculo"',
                      style: GoogleFonts.cormorantGaramond(
                        fontSize: 16,
                        color: Colors.black87,
                        height: 1.4,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 4,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      referencia,
                      style: GoogleFonts.dmSans(
                        fontSize: 10,
                        letterSpacing: 2,
                        fontWeight: FontWeight.w500,
                        color: Colors.black54,
                      ),
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
}
