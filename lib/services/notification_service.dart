import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationService {
  static final _plugin = FlutterLocalNotificationsPlugin();
  static bool _initialized = false;

  static const _motivationalMessages = [
    'Dios no se ha olvidado de ti. Vuelve a casa, Él te espera.',
    'Aunque el tiempo pase, Su amor no cambia. Vuelve a Él.',
    'No importa cuánto tiempo haya pasado, Dios sigue a tu lado.',
    'Él nunca se aleja. Da el primer paso y regresa a Su presencia.',
    'Cada día es una nueva oportunidad para volver a Dios.',
  ];

  static Future<void> init() async {
    if (_initialized) return;
    const androidSettings =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );
    const settings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );
    await _plugin.initialize(settings: settings);
    _initialized = true;
  }

  static Future<bool> requestPermission() async {
    final android = _plugin.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    if (android != null) {
      final granted = await android.requestNotificationsPermission();
      return granted ?? false;
    }
    final ios = _plugin.resolvePlatformSpecificImplementation<
        IOSFlutterLocalNotificationsPlugin>();
    if (ios != null) {
      final granted = await ios.requestPermissions(
        alert: true,
        badge: true,
        sound: true,
      );
      return granted ?? false;
    }
    return true;
  }

  static Future<void> showMotivational() async {
    final index = DateTime.now().day % _motivationalMessages.length;
    final message = _motivationalMessages[index];

    const androidDetails = AndroidNotificationDetails(
      'vida_motivation',
      'Motivación',
      channelDescription: 'Recordatorios espirituales',
      importance: Importance.high,
      priority: Priority.high,
    );
    const iosDetails = DarwinNotificationDetails();
    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _plugin.show(
      id: DateTime.now().millisecondsSinceEpoch ~/ 1000,
      title: 'VIDA',
      body: message,
      notificationDetails: details,
    );

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('last_notification_date', _today());
  }

  static Future<int> daysSinceLastOpen() async {
    final prefs = await SharedPreferences.getInstance();
    final last = prefs.getString('last_open_date') ?? '';
    if (last.isEmpty) return 0;
    final lastDate = DateTime.tryParse(last);
    if (lastDate == null) return 0;
    return DateTime.now().difference(lastDate).inDays;
  }

  static Future<bool> shouldShowToday() async {
    final prefs = await SharedPreferences.getInstance();
    final lastNotif = prefs.getString('last_notification_date') ?? '';
    return lastNotif != _today();
  }

  static String _today() {
    final d = DateTime.now();
    return '${d.year}-${d.month.toString().padLeft(2, '0')}-${d.day.toString().padLeft(2, '0')}';
  }
}
