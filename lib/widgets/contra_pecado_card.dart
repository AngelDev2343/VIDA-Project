import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../data/phrases.dart';

class ContraPecadoCard extends StatelessWidget {
  const ContraPecadoCard({super.key});

  @override
  Widget build(BuildContext context) {
    final phrase = getTodaysPhrase();

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        image: DecorationImage(
          image: AssetImage(phrase.imageAsset),
          fit: BoxFit.cover,
        ),
      ),
      clipBehavior: Clip.hardEdge,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '"${phrase.text}"',
              style: GoogleFonts.cormorantGaramond(
                fontSize: 18,
                color: Colors.white,
                height: 1.5,
                fontStyle: FontStyle.italic,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              'Contra pecado',
              style: GoogleFonts.dmSans(
                fontSize: 10,
                letterSpacing: 2,
                fontWeight: FontWeight.w500,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
