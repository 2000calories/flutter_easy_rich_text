import 'package:flutter/widgets.dart';

import 'easy_rich_text_pattern.dart';
import 'patterns.dart';

class EasyRichTextPatterns {
  EasyRichTextPatterns._();

  static final bold = EasyRichTextPattern(
    targetString: EasyRegexPattern.boldPattern,
    matchWordBoundaries: false,
    matchBuilder: (context, match) {
      return TextSpan(
        text: match?[0]?.substring(1, match[0]!.length - 1),
        style: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
      );
    },
  );

  static final italic = EasyRichTextPattern(
    targetString: EasyRegexPattern.italicPattern,
    matchWordBoundaries: false,
    matchBuilder: (context, match) {
      return TextSpan(
        text: match?[0]?.substring(1, match[0]!.length - 1),
        style: const TextStyle(
          fontStyle: FontStyle.italic,
        ),
      );
    },
  );
}
