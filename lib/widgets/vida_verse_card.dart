import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VidaVerseCard extends StatelessWidget {
  final String verseText;
  final String reference;
  final VoidCallback? onShare;
  final VoidCallback? onSave;

  const VidaVerseCard({
    super.key,
    required this.verseText,
    required this.reference,
    this.onShare,
    this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: cs.primary,
        borderRadius: BorderRadius.circular(24),
      ),
      clipBehavior: Clip.hardEdge,
      child: Stack(
        children: [
          // Decorative circle background
          Positioned(
            right: -35,
            top: -35,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),
          Positioned(
            right: 20,
            bottom: -45,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 22, 20, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'TU VERSÍCULO · VIDA',
                  style: GoogleFonts.dmSans(
                    fontSize: 10,
                    letterSpacing: 2,
                    fontWeight: FontWeight.w500,
                    color: Colors.white.withValues(alpha: 0.55),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '"$verseText"',
                  style: GoogleFonts.cormorantGaramond(
                    fontSize: 17,
                    color: Colors.white,
                    height: 1.55,
                    fontStyle: FontStyle.italic,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  '— $reference',
                  style: GoogleFonts.dmSans(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.6),
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _ActionChip(
                      icon: Icons.share_rounded,
                      label: 'Compartir',
                      onTap: onShare,
                    ),
                    const SizedBox(width: 8),
                    _ActionChip(
                      icon: Icons.bookmark_border_rounded,
                      label: 'Guardar',
                      onTap: onSave,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionChip({
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.18),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: Colors.white),
            const SizedBox(width: 5),
            Text(
              label,
              style: GoogleFonts.dmSans(fontSize: 12, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}