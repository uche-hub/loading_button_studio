import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:button_loading_fx/button_loading_fx.dart';

void main() {
  testWidgets('LoadingButtonStudio renders with pulsing animation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingButtonStudio(
            animation: ButtonAnimationEffect.pulsing,
            effectColor: Colors.white,
          ),
        ),
      ),
    );

    expect(find.byType(LoadingButtonStudio), findsOneWidget);
  });

  testWidgets('LoadingButtonStudio renders with liquid splash animation', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingButtonStudio(
            animation: ButtonAnimationEffect.liquidSplash,
            effectColor: Colors.blue,
          ),
        ),
      ),
    );

    expect(find.byType(LoadingButtonStudio), findsOneWidget);
  });

  testWidgets('LoadingButtonStudio accepts custom properties', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: LoadingButtonStudio(
            animation: ButtonAnimationEffect.pulsing,
            effectColor: Colors.orange,
            size: 30.0,
            strokeWidth: 3.0,
            duration: Duration(milliseconds: 500),
          ),
        ),
      ),
    );

    expect(find.byType(LoadingButtonStudio), findsOneWidget);
  });
}