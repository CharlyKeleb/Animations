import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:test_project/spongebob/home.dart';

void main() {
  testWidgets('SpongeBobHome animates (repaints) over time', (tester) async {
    await tester.pumpWidget(const SpongeBobHome());

    // Capture the current CustomPaint painter instance.
    final firstPaint = tester.widget<CustomPaint>(find.byType(CustomPaint));
    final firstPainter = firstPaint.painter;

    // Let the stroke animation and idle bob tick.
    await tester.pump(const Duration(milliseconds: 700));

    final secondPaint = tester.widget<CustomPaint>(find.byType(CustomPaint));
    final secondPainter = secondPaint.painter;

    // Because our CustomPaint is rebuilt by an AnimatedBuilder, the painter
    // instance should change over time.
    expect(identical(firstPainter, secondPainter), isFalse);
  });
}
