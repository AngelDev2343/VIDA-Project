import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vida_app/main.dart';

void main() {
  testWidgets('VidaApp renders splash when no name stored', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const VidaApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.text('VIDA'), findsWidgets);
    expect(find.text('Personaliza tu experiencia'), findsOneWidget);
  });

  testWidgets('VidaApp renders home when name is stored', (tester) async {
    SharedPreferences.setMockInitialValues({'user_name': 'Test'});
    await tester.pumpWidget(const VidaApp());
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 100));
    expect(find.textContaining('Test'), findsWidgets);
    expect(find.text('VIDA'), findsWidgets);
  });
}
