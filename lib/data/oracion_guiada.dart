import 'package:shared_preferences/shared_preferences.dart';

/// Preferencias y reglas de Oración guiada.
class OracionGuiadaService {
  static const _kDone = 'oracion_guiada_completed_once';
  static const _kInvite = 'oracion_guiada_invite_shown';
  static const _kFirstOpen = 'app_first_open_iso';

  /// Días de uso antes de sugerir oración (solo una vez).
  static const inviteAfterDays = 2;

  static Future<void> ensureFirstOpenTracked() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getString(_kFirstOpen) == null) {
      await prefs.setString(_kFirstOpen, DateTime.now().toIso8601String());
    }
  }

  static Future<bool> hasCompletedOnce() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_kDone) ?? false;
  }

  static Future<void> markCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kDone, true);
  }

  static Future<bool> shouldShowInvite() async {
    final prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(_kInvite) ?? false) return false;
    if (prefs.getBool(_kDone) ?? false) return false;

    await ensureFirstOpenTracked();
    final raw = prefs.getString(_kFirstOpen);
    if (raw == null) return false;
    final first = DateTime.tryParse(raw);
    if (first == null) return false;
    final days = DateTime.now().difference(first).inDays;
    return days >= inviteAfterDays;
  }

  static Future<void> markInviteShown() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kInvite, true);
  }
}

class OracionPaso {
  final String id;
  final String title;
  final String prompt;
  final String hint;
  final IconDataName icon;

  const OracionPaso({
    required this.id,
    required this.title,
    required this.prompt,
    required this.hint,
    required this.icon,
  });
}

/// Iconos como string para no acoplar Flutter en data pura… usamos IconData en screen.
enum IconDataName { favorite, repent, praise, trust, faith }

/// Pasos inspirados en Mateo (gratitud, arrepentimiento, alabanza, confianza, fe).
const oracionPasos = <OracionPaso>[
  OracionPaso(
    id: 'gratitud',
    title: 'Gratitud',
    prompt:
        'Dale gracias a Dios por lo que tienes hoy: personas, aliento, '
        'oportunidades… lo grande y lo pequeño.',
    hint: 'Señor, te doy gracias por…',
    icon: IconDataName.favorite,
  ),
  OracionPaso(
    id: 'arrepentimiento',
    title: 'Arrepentimiento',
    prompt:
        'Con humildad, reconoce lo que te aleja de Él. '
        'Su misericordia es nueva cada mañana.',
    hint: 'Señor, perdóname por…',
    icon: IconDataName.repent,
  ),
  OracionPaso(
    id: 'alabanza',
    title: 'Alabanza',
    prompt:
        'Exalta quién es Dios: santo, fiel, bueno. '
        'No solo por lo que hace, sino por quién es.',
    hint: 'Señor, te alabo porque…',
    icon: IconDataName.praise,
  ),
  OracionPaso(
    id: 'confianza',
    title: 'Confianza',
    prompt:
        'Pon en Sus manos lo que te pesa. '
        'Él cuida de ti; puedes descansar en Su cuidado.',
    hint: 'Señor, confío en Ti con…',
    icon: IconDataName.trust,
  ),
  OracionPaso(
    id: 'fe',
    title: 'Fe',
    prompt:
        'Afirma tu fe: cree que Él oye, responde y camina contigo. '
        'Aunque no veas todo, Él es fiel.',
    hint: 'Señor, creo que…',
    icon: IconDataName.faith,
  ),
];
