import 'package:flutter/material.dart';
import '../data/gallery_images.dart';
import '../theme/app_theme.dart';
import 'image_editor_screen.dart';

class GalleryScreen extends StatelessWidget {
  const GalleryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Plantillas',
          style: TextStyle(
            fontFamily: 'Cormorant Garamond',
            fontSize: 28,
            fontWeight: FontWeight.w600,
            color: AppColors.emerald600,
          ),
        ),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: galleryAssets.length,
        itemBuilder: (_, i) {
          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => ImageEditorScreen(
                  imageAsset: galleryAssets[i],
                ),
              ),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.asset(
                galleryAssets[i],
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }
}
