import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_application_1/main.dart'; // تأكد أن هذا هو المسار الصحيح للملف الرئيسي

void main() {
  testWidgets('Counter increments test', (WidgetTester tester) async {
    // بناء التطبيق وتشغيل إطار العمل
    await tester.pumpWidget(MyApp());

    // التحقق من أن العداد يبدأ من 0
    expect(find.text('0'), findsOneWidget);
    expect(find.text('1'), findsNothing);

    // الضغط على زر الإضافة
    await tester.tap(find.byIcon(Icons.add));
    await tester.pump(); // إعادة رسم الواجهة بعد الضغط

    // التحقق من أن العداد زاد إلى 1
    expect(find.text('0'), findsNothing);
    expect(find.text('1'), findsOneWidget);
  });
}


