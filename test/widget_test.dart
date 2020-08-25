

import 'package:drop_here_mobile/counter/ui/pages/first_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';


void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(App());

    expect(find.text('Flutter Form Validation'), findsOneWidget);
    expect(find.text('Form Submitted Successfully'), findsNothing);

    expect(find.byIcon(Icons.email), findsOneWidget);
    expect(find.byIcon(Icons.lock), findsOneWidget);

  });
}
