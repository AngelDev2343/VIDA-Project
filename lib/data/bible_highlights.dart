import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'bible_data.dart';

/// Available highlighter swatches (light fills; dark mode adjusts in UI).
class BibleHighlightColors {
  static const yellow = Color(0xFFFFF176);
  static const green = Color(0xFFA5D6A7);
  static const blue = Color(0xFF90CAF9);

  static const all = <Color>[yellow, green, blue];

  static Color resolve(int? value) {
    if (value == null) return yellow;
    for (final c in all) {
      // ignore: deprecated_member_use
      if (c.value == value) return c;
    }
    return Color(value);
  }

  /// Readable fill on light/dark surfaces.
  static Color fill(Color base, {required bool isDark}) {
    if (isDark) {
      return Color.lerp(base, const Color(0xFF1A1A1A), 0.55)!
          .withValues(alpha: 0.72);
    }
    return base.withValues(alpha: 0.78);
  }
}

class HighlightedVerse {
  final int bookIndex;
  final int chapter;
  final int verse;
  final int verseEnd;
  final String bookName;
  final String text;
  final Color color;

  const HighlightedVerse({
    required this.bookIndex,
    required this.chapter,
    required this.verse,
    int? verseEnd,
    required this.bookName,
    required this.text,
    required this.color,
  }) : verseEnd = verseEnd ?? verse;

  String get citation => verse == verseEnd
      ? '$bookName $chapter:$verse'
      : '$bookName $chapter:$verse–$verseEnd';

  String get key => BibleHighlights.verseKey(bookIndex, chapter, verse);

  bool get isRange => verseEnd > verse;
}

class BibleHighlights {
  static const prefsKey = 'bible_highlights';

  /// Bumps whenever highlights are persisted so open screens can refresh.
  static final ValueNotifier<int> changes = ValueNotifier(0);

  static String verseKey(int bookIndex, int chapter, int verse) =>
      '$bookIndex:$chapter:$verse';

  /// Contiguous same-color block containing [verse] within a chapter.
  static (int from, int to) contiguousRange({
    required Map<String, int> map,
    required int bookIndex,
    required int chapter,
    required int verse,
    required int verseCount,
  }) {
    final color = map[verseKey(bookIndex, chapter, verse)];
    if (color == null) return (verse, verse);
    var from = verse;
    var to = verse;
    while (from > 1 &&
        map[verseKey(bookIndex, chapter, from - 1)] == color) {
      from--;
    }
    while (to < verseCount &&
        map[verseKey(bookIndex, chapter, to + 1)] == color) {
      to++;
    }
    return (from, to);
  }

  /// Loads `verseKey → colorValue`. Migrates legacy key-only entries to yellow.
  static Future<Map<String, int>> loadMap() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getStringList(prefsKey) ?? const [];
    final map = <String, int>{};
    // ignore: deprecated_member_use
    final defaultColor = BibleHighlightColors.yellow.value;

    for (final entry in raw) {
      final parts = entry.split('|');
      if (parts.length == 2) {
        final key = parts[0];
        final color = int.tryParse(parts[1]) ?? defaultColor;
        if (_validKey(key)) map[key] = color;
        continue;
      }
      // Legacy: "book:chapter:verse"
      if (_validKey(entry)) map[entry] = defaultColor;
    }
    return map;
  }

  static bool _validKey(String key) {
    final parts = key.split(':');
    if (parts.length != 3) return false;
    return parts.every((p) => int.tryParse(p) != null);
  }

  static Future<void> saveMap(Map<String, int> map) async {
    final prefs = await SharedPreferences.getInstance();
    final list = map.entries.map((e) => '${e.key}|${e.value}').toList();
    await prefs.setStringList(prefsKey, list);
    changes.value++;
  }

  static Future<Set<String>> loadKeys() async {
    final map = await loadMap();
    return map.keys.toSet();
  }

  static Future<void> saveKeys(Set<String> keys) async {
    // ignore: deprecated_member_use
    final yellow = BibleHighlightColors.yellow.value;
    final existing = await loadMap();
    final map = <String, int>{};
    for (final k in keys) {
      map[k] = existing[k] ?? yellow;
    }
    await saveMap(map);
  }

  /// Applies [color] to verses [fromVerse]…[toVerse] (inclusive) in one chapter.
  static Future<void> applyRange({
    required int bookIndex,
    required int chapter,
    required int fromVerse,
    required int toVerse,
    required Color color,
  }) async {
    final map = await loadMap();
    final a = fromVerse < toVerse ? fromVerse : toVerse;
    final b = fromVerse < toVerse ? toVerse : fromVerse;
    // ignore: deprecated_member_use
    final colorVal = color.value;
    for (var v = a; v <= b; v++) {
      map[verseKey(bookIndex, chapter, v)] = colorVal;
    }
    await saveMap(map);
  }

  static Future<void> removeRange({
    required int bookIndex,
    required int chapter,
    required int fromVerse,
    required int toVerse,
  }) async {
    final map = await loadMap();
    final a = fromVerse < toVerse ? fromVerse : toVerse;
    final b = fromVerse < toVerse ? toVerse : fromVerse;
    for (var v = a; v <= b; v++) {
      map.remove(verseKey(bookIndex, chapter, v));
    }
    await saveMap(map);
  }

  static Future<bool> toggle(int bookIndex, int chapter, int verse,
      {Color color = BibleHighlightColors.yellow}) async {
    final map = await loadMap();
    final key = verseKey(bookIndex, chapter, verse);
    final added = !map.containsKey(key);
    if (added) {
      // ignore: deprecated_member_use
      map[key] = color.value;
    } else {
      map.remove(key);
    }
    await saveMap(map);
    return added;
  }

  static Future<List<HighlightedVerse>> loadVerses() async {
    final map = await loadMap();
    if (map.isEmpty) return const [];

    final bible = await BibleService.instance.load();
    final items = <HighlightedVerse>[];

    for (final entry in map.entries) {
      final parts = entry.key.split(':');
      if (parts.length != 3) continue;
      final bookIndex = int.tryParse(parts[0]);
      final chapter = int.tryParse(parts[1]);
      final verse = int.tryParse(parts[2]);
      if (bookIndex == null || chapter == null || verse == null) continue;
      if (bookIndex < 0 || bookIndex >= bible.books.length) continue;
      final book = bible.books[bookIndex];
      final verses = book.chapter(chapter);
      if (verse < 1 || verse > verses.length) continue;
      items.add(
        HighlightedVerse(
          bookIndex: bookIndex,
          chapter: chapter,
          verse: verse,
          bookName: book.name,
          text: verses[verse - 1],
          color: BibleHighlightColors.resolve(entry.value),
        ),
      );
    }

    items.sort((a, b) {
      final byBook = a.bookIndex.compareTo(b.bookIndex);
      if (byBook != 0) return byBook;
      final byChapter = a.chapter.compareTo(b.chapter);
      if (byChapter != 0) return byChapter;
      return a.verse.compareTo(b.verse);
    });

    return groupConsecutive(items);
  }

  /// Merges consecutive same-color verses in a chapter into ranges
  /// (e.g. Juan 1:1–4 with joined text).
  static List<HighlightedVerse> groupConsecutive(List<HighlightedVerse> items) {
    if (items.isEmpty) return const [];

    final grouped = <HighlightedVerse>[];
    var runStart = items.first;
    var runEnd = items.first.verse;
    final runTexts = <String>[items.first.text];

    void flush() {
      grouped.add(
        HighlightedVerse(
          bookIndex: runStart.bookIndex,
          chapter: runStart.chapter,
          verse: runStart.verse,
          verseEnd: runEnd,
          bookName: runStart.bookName,
          text: runTexts.join(' '),
          color: runStart.color,
        ),
      );
    }

    for (var i = 1; i < items.length; i++) {
      final cur = items[i];
      // ignore: deprecated_member_use
      final sameColor = cur.color.value == runStart.color.value;
      final consecutive = cur.bookIndex == runStart.bookIndex &&
          cur.chapter == runStart.chapter &&
          sameColor &&
          cur.verse == runEnd + 1;
      if (consecutive) {
        runEnd = cur.verse;
        runTexts.add(cur.text);
      } else {
        flush();
        runStart = cur;
        runEnd = cur.verse;
        runTexts
          ..clear()
          ..add(cur.text);
      }
    }
    flush();
    return grouped;
  }
}
