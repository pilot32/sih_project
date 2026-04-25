import 'package:flutter_test/flutter_test.dart';
import 'package:digital_learning_application/main.dart';

void main() {
  testWidgets('App loads and shows login screen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    // Verify the login screen renders
    expect(find.text('Nabha Digital Education'), findsOneWidget);
    expect(find.text('Student'), findsOneWidget);
    expect(find.text('Teacher'), findsOneWidget);
  });
}
