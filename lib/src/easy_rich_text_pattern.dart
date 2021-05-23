import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

typedef EasyRichTextMatchBuilder = InlineSpan Function(
    BuildContext context, RegExpMatch? match);

class EasyRichTextPattern {
  ///target string that you want to format
  final dynamic targetString;

  ///string before target string.
  ///useful when you want to format text after specified words
  final String stringBeforeTarget;

  ///string after target string.
  ///useful when you want to format text before specified words
  final String stringAfterTarget;

  //Apply Word Boundaries in RegExp. The default value is true.
  ///when all values are set to true. matchLeftWordBoundary and matchRightWordBoundary has higher priority than matchWordBoundaries.
  final bool matchWordBoundaries;

  ///Apply only left Word Boundary in RegExp. The default value is false.
  /// It Will be set to false when matchWordBoundaries is true.
  ////when all values are set to true. matchLeftWordBoundary has higher priority than matchWordBoundaries and matchRightWordBoundary.
  final bool matchLeftWordBoundary;

  ///Apply only left Word Boundary in RegExp. The default value is false.
  ///It Will be set to false when matchWordBoundaries or matchLeftWordBoundary is true.
  ////when all values are set to true. matchRightWordBoundary have higher priority than matchWordBoundaries but lower priority than matchLeftWordBoundary.
  final bool matchRightWordBoundary;

  ///convert targetString to superScript
  ///superscript has higher priority than subscript
  final bool superScript;

  ///convert targetString to subscript
  final bool subScript;

  ///Style of target text
  final TextStyle? style;

  ///apply url_launcher, support email, website, and telephone
  final String? urlType;

  ///GestureRecognizer
  final GestureRecognizer? recognizer;

  ///set true if the targetString contains specified characters \[]()^*+?.$-{}|!
  final bool hasSpecialCharacters;

  ///match first, last, or all [0, 1, 'last']
  ///defalut match all
  final dynamic matchOption;

  final EasyRichTextMatchBuilder? matchBuilder;

  EasyRichTextPattern({
    Key? key,
    required this.targetString,
    this.stringBeforeTarget = '',
    this.stringAfterTarget = '',
    this.matchWordBoundaries = true,
    this.matchLeftWordBoundary = true,
    this.matchRightWordBoundary = true,
    this.superScript = false,
    this.subScript = false,
    this.style,
    this.urlType,
    this.recognizer,
    this.hasSpecialCharacters = false,
    this.matchOption = 'all',
    this.matchBuilder,
  });

  EasyRichTextPattern copyWith({
    targetString,
    stringBeforeTarget,
    stringAfterTarget,
    matchWordBoundaries,
    matchLeftWordBoundary,
    matchRightWordBoundary,
    superScript,
    subScript,
    style,
    urlType,
    recognizer,
    hasSpecialCharacters,
    matchOption,
  }) {
    return EasyRichTextPattern(
      targetString: targetString ?? this.targetString,
      stringBeforeTarget: stringBeforeTarget ?? this.stringBeforeTarget,
      stringAfterTarget: stringAfterTarget ?? this.stringAfterTarget,
      matchWordBoundaries: matchWordBoundaries ?? this.matchWordBoundaries,
      matchLeftWordBoundary:
          matchLeftWordBoundary ?? this.matchLeftWordBoundary,
      matchRightWordBoundary:
          matchRightWordBoundary ?? this.matchRightWordBoundary,
      superScript: superScript ?? this.superScript,
      subScript: subScript ?? this.subScript,
      style: style ?? this.style,
      urlType: urlType ?? this.urlType,
      recognizer: recognizer ?? this.recognizer,
      hasSpecialCharacters: hasSpecialCharacters ?? this.hasSpecialCharacters,
      matchOption: matchOption ?? this.matchOption,
    );
  }
}
