import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:easy_rich_text/easy_rich_text.dart';

void main() {
  testWidgets('EasyRichText test', (WidgetTester tester) async {
    // Create the widget by telling the tester to build it.
    String str =
        "This is a EasyRichText example. I want blue font. I want bold font. I want italic font.";
    await tester.pumpWidget(MaterialApp(
        home: EasyRichText(
      str,
      patternList: [
        EasyRichTextPattern(
            targetString: 'blue',
            stringBeforeTarget: 'want',
            superScript: true),
      ],
    )));
  });

  test('compare EasyRichText with Text', () {
    String str =
        "This is a EasyRichText example. I want blue font. I want bold font. I want italic font.";

    var time1 = new DateTime.now();
    for (var i = 0; i < 100000; i++) {
      EasyRichText(
        str,
        patternList: [
          EasyRichTextPattern(
              targetString: 'bold',
              style: TextStyle(fontWeight: FontWeight.bold)),
        ],
      );
    }

    var time2 = new DateTime.now();
    print(time2.difference(time1).inMicroseconds.toString());

    var time3 = new DateTime.now();
    for (var i = 0; i < 100000; i++) {
      RichText(
        text: TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'This is a EasyRichText example. I want blue font. I want ',
            ),
            TextSpan(
                text: 'bold', style: TextStyle(fontWeight: FontWeight.bold)),
            TextSpan(text: ' font. I want italic font.'),
          ],
        ),
      );
    }
    var time4 = new DateTime.now();
    print(time4.difference(time3).inMicroseconds.toString());
  });
}
