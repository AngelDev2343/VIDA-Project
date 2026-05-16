import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class BibleStudy {
  final String id;
  final String name;
  final DateTime date;
  final String book;
  final String verses;
  final String reflection;

  const BibleStudy({
    required this.id,
    required this.name,
    required this.date,
    required this.book,
    this.verses = '',
    this.reflection = '',
  });

  BibleStudy copyWith({
    String? name,
    DateTime? date,
    String? book,
    String? verses,
    String? reflection,
  }) =>
      BibleStudy(
        id: id,
        name: name ?? this.name,
        date: date ?? this.date,
        book: book ?? this.book,
        verses: verses ?? this.verses,
        reflection: reflection ?? this.reflection,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'date': date.toIso8601String(),
        'book': book,
        'verses': verses,
        'reflection': reflection,
      };

  factory BibleStudy.fromJson(Map<String, dynamic> json) => BibleStudy(
        id: json['id'] as String,
        name: json['name'] as String,
        date: DateTime.parse(json['date'] as String),
        book: json['book'] as String,
        verses: json['verses'] as String? ?? '',
        reflection: json['reflection'] as String? ?? '',
      );
}

class BibleStudyService {
  static const _key = 'bible_studies';

  static Future<List<BibleStudy>> getAll() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key) ?? '[]';
    final list = jsonDecode(raw) as List;
    return list
        .map((e) => BibleStudy.fromJson(e as Map<String, dynamic>))
        .toList()
      ..sort((a, b) => b.date.compareTo(a.date));
  }

  static Future<void> save(BibleStudy study) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key) ?? '[]';
    final list = jsonDecode(raw) as List;
    list.add(study.toJson());
    await prefs.setString(_key, jsonEncode(list));
  }

  static Future<void> update(BibleStudy study) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key) ?? '[]';
    final list = jsonDecode(raw) as List;
    final i = list.indexWhere(
        (e) => (e as Map<String, dynamic>)['id'] == study.id);
    if (i != -1) {
      list[i] = study.toJson();
      await prefs.setString(_key, jsonEncode(list));
    }
  }

  static Future<void> delete(String id) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_key) ?? '[]';
    final list = jsonDecode(raw) as List;
    list.removeWhere((e) => (e as Map<String, dynamic>)['id'] == id);
    await prefs.setString(_key, jsonEncode(list));
  }
}
