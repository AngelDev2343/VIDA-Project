import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class StreakService {
  static const _countKey = 'streak_count';
  static const _lastDateKey = 'last_open_date';
  static const _bestKey = 'best_streak';
  static const _datesKey = 'streak_dates';

  static Future<int> getCount() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_countKey) ?? 0;
  }

  static Future<int> getBest() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(_bestKey) ?? 0;
  }

  static Future<Set<String>> getDates() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_datesKey) ?? '[]';
    return Set<String>.from(jsonDecode(raw) as List);
  }

  static Future<void> checkAndUpdate() async {
    final prefs = await SharedPreferences.getInstance();
    final today = _today();

    final lastDate = prefs.getString(_lastDateKey) ?? '';
    if (lastDate == today) return;

    final count = prefs.getInt(_countKey) ?? 0;
    final best = prefs.getInt(_bestKey) ?? 0;
    final raw = prefs.getString(_datesKey) ?? '[]';
    final dates = List<String>.from(jsonDecode(raw) as List);

    final int newCount;
    if (lastDate == _yesterday()) {
      newCount = count + 1;
    } else {
      newCount = 1;
    }

    dates.add(today);
    final newBest = newCount > best ? newCount : best;

    await prefs.setInt(_countKey, newCount);
    await prefs.setString(_lastDateKey, today);
    await prefs.setInt(_bestKey, newBest);
    await prefs.setString(_datesKey, jsonEncode(dates));
  }

  static String _today() => _format(DateTime.now());

  static String _yesterday() =>
      _format(DateTime.now().subtract(const Duration(days: 1)));

  static String _format(DateTime d) =>
      '${d.year}-${_pad(d.month)}-${_pad(d.day)}';

  static String _pad(int n) => n.toString().padLeft(2, '0');
}
