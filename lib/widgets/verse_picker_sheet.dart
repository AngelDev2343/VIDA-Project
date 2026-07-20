import 'package:flutter/material.dart';
import '../data/bible_data.dart';
import '../theme/app_theme.dart';

class PickedVerse {
  final String text;
  final String reference;

  const PickedVerse({required this.text, required this.reference});

  String get formatted => '"$text"\n— $reference';
}

/// Bottom sheet to pick a verse or range from RVR1909.
Future<PickedVerse?> showVersePickerSheet(BuildContext context) async {
  final bible = await BibleService.instance.load();
  if (!context.mounted) return null;

  var bookIndex = 42;
  var chapter = 1;
  var verse = 1;
  var verseEnd = 1;

  void clamp(void Function(void Function()) setLocal) {
    setLocal(() {
      bookIndex = bookIndex.clamp(0, bible.books.length - 1);
      final book = bible.books[bookIndex];
      chapter = chapter.clamp(1, book.chapterCount);
      final count = book.chapter(chapter).length;
      final maxV = count < 1 ? 1 : count;
      verse = verse.clamp(1, maxV);
      verseEnd = verseEnd.clamp(1, maxV);
      if (verseEnd < verse) verseEnd = verse;
    });
  }

  Future<int?> pickNumber(
    BuildContext ctx, {
    required String title,
    required int count,
    required int current,
  }) {
    return showVerseNumberSheet(
      ctx,
      title: title,
      count: count,
      current: current,
    );
  }

  return showModalBottomSheet<PickedVerse>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (ctx) {
      return StatefulBuilder(
        builder: (ctx, setLocal) {
          final book = bible.books[bookIndex];
          final verseCount = book.chapter(chapter).length;
          final from = verse <= verseEnd ? verse : verseEnd;
          final to = verse <= verseEnd ? verseEnd : verse;
          final parts = <String>[];
          final verses = book.chapter(chapter);
          for (var v = from; v <= to; v++) {
            if (v >= 1 && v <= verses.length) parts.add(verses[v - 1]);
          }
          final text = parts.join(' ');
          final reference = from == to
              ? '${book.name} $chapter:$from'
              : '${book.name} $chapter:$from–$to';

          return Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              0,
              20,
              20 + MediaQuery.viewInsetsOf(ctx).bottom,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Agregar versículo',
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w700,
                    fontSize: 16,
                    color: AppColors.emerald900,
                  ),
                ),
                const SizedBox(height: 12),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _chip(
                      label: book.name,
                      onTap: () async {
                        final selected = await showModalBottomSheet<int>(
                          context: ctx,
                          isScrollControlled: true,
                          showDragHandle: true,
                          builder: (bookCtx) => DraggableScrollableSheet(
                            expand: false,
                            initialChildSize: 0.7,
                            minChildSize: 0.4,
                            maxChildSize: 0.92,
                            builder: (_, scroll) => ListView.builder(
                              controller: scroll,
                              itemCount: bible.books.length,
                              itemBuilder: (_, i) {
                                final b = bible.books[i];
                                return ListTile(
                                  selected: i == bookIndex,
                                  title: Text(b.name),
                                  onTap: () => Navigator.pop(bookCtx, i),
                                );
                              },
                            ),
                          ),
                        );
                        if (selected == null) return;
                        setLocal(() {
                          bookIndex = selected;
                          chapter = 1;
                          verse = 1;
                          verseEnd = 1;
                        });
                        clamp(setLocal);
                      },
                    ),
                    _chip(
                      label: 'Cap. $chapter',
                      onTap: () async {
                        final n = await pickNumber(
                          ctx,
                          title: 'Capítulo',
                          count: book.chapterCount,
                          current: chapter,
                        );
                        if (n == null) return;
                        setLocal(() {
                          chapter = n;
                          verse = 1;
                          verseEnd = 1;
                        });
                        clamp(setLocal);
                      },
                    ),
                    _chip(
                      label: 'v. $verse',
                      onTap: () async {
                        final n = await pickNumber(
                          ctx,
                          title: 'Desde',
                          count: verseCount < 1 ? 1 : verseCount,
                          current: verse,
                        );
                        if (n == null) return;
                        setLocal(() {
                          verse = n;
                          if (verseEnd < verse) verseEnd = verse;
                        });
                        clamp(setLocal);
                      },
                    ),
                    _chip(
                      label: 'hasta $verseEnd',
                      onTap: () async {
                        final n = await pickNumber(
                          ctx,
                          title: 'Hasta el versículo',
                          count: verseCount < 1 ? 1 : verseCount,
                          current: verseEnd,
                        );
                        if (n == null) return;
                        setLocal(() {
                          verseEnd = n;
                          if (verse > verseEnd) verse = verseEnd;
                        });
                        clamp(setLocal);
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  reference,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                    color: AppColors.emerald600,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  text,
                  maxLines: 4,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontFamily: 'Cormorant Garamond',
                    fontSize: 15,
                    height: 1.35,
                    color: AppColors.emerald800,
                  ),
                ),
                const SizedBox(height: 16),
                FilledButton(
                  onPressed: text.isEmpty
                      ? null
                      : () => Navigator.pop(
                            ctx,
                            PickedVerse(text: text, reference: reference),
                          ),
                  child: const Text('Usar versículo'),
                ),
              ],
            ),
          );
        },
      );
    },
  );
}

Widget _chip({required String label, required VoidCallback onTap}) {
  return Material(
    color: AppColors.emerald50,
    borderRadius: BorderRadius.circular(10),
    child: InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(10),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(
                fontFamily: 'DM Sans',
                fontWeight: FontWeight.w600,
                fontSize: 13,
                color: AppColors.emerald900,
              ),
            ),
            const SizedBox(width: 4),
            Icon(Icons.expand_more_rounded,
                size: 18, color: AppColors.emerald600),
          ],
        ),
      ),
    ),
  );
}

/// Compact number grid used for “hasta el versículo” inside another sheet.
Future<int?> showVerseNumberSheet(
  BuildContext context, {
  required String title,
  required int count,
  required int current,
}) {
  return showModalBottomSheet<int>(
    context: context,
    isScrollControlled: true,
    useRootNavigator: true,
    showDragHandle: true,
    builder: (ctx) {
      final maxH = MediaQuery.sizeOf(ctx).height * 0.72;
      final rows = (count / 5).ceil().clamp(1, 100);
      // ~52px per row + title/padding; cap to maxH so GridView can scroll.
      final idealH = 72.0 + rows * 52.0 + 24.0;
      final height = idealH.clamp(280.0, maxH);
      return SafeArea(
        child: SizedBox(
          height: height,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                child: Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'DM Sans',
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: AppColors.emerald900,
                  ),
                ),
              ),
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                    childAspectRatio: 1.15,
                  ),
                  itemCount: count,
                  itemBuilder: (_, i) {
                    final n = i + 1;
                    final sel = n == current;
                    return Material(
                      color: sel ? AppColors.emerald600 : AppColors.emerald50,
                      borderRadius: BorderRadius.circular(10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(10),
                        onTap: () => Navigator.pop(ctx, n),
                        child: Center(
                          child: Text(
                            '$n',
                            style: TextStyle(
                              fontFamily: 'DM Sans',
                              fontWeight: FontWeight.w600,
                              fontSize: 14,
                              color: sel ? Colors.white : AppColors.emerald800,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}
