import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:vida_app/main.dart';

void main() {
  testWidgets('VidaApp renders splash when no name stored', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const VidaApp());
    await tester.pump();
    expect(find.text('VIDA'), findsWidgets);
    expect(find.text('Bienvenido'), findsOneWidget);
  });

  testWidgets('VidaApp renders home when name is stored', (tester) async {
    SharedPreferences.setMockInitialValues({'user_name': 'Test'});
    await tester.pumpWidget(const VidaApp());
    await tester.pump();
    expect(find.text('Buenos días, Test'), findsOneWidget);
  });
}
