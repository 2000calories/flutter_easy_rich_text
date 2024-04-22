import 'package:easy_rich_text/src/easy_rich_text_pattern.dart';
import 'package:easy_rich_text/src/patterns.dart';
import 'package:flutter/widgets.dart';

abstract class EasyRichTextPatterns {
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
