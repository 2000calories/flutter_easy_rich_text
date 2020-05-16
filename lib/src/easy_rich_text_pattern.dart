import 'package:flutter/widgets.dart';

class EasyRichTextPattern {
  ///target string that you want to format
  final String targetString;

  ///string before target string.
  ///useful when you want to format text after specified words
  final String stringBeforeTarget;
  // final String stringAfterTarget;
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

  ///superscript has higher priority than subscript
  final bool superScript;

  final bool subScript;

  ///Style of target text
  final TextStyle style;

  EasyRichTextPattern(
      {Key key,
      @required this.targetString,
      this.stringBeforeTarget,
      //this.stringAfterTarget,
      this.matchWordBoundaries = true,
      this.matchLeftWordBoundary = false,
      this.matchRightWordBoundary = false,
      this.superScript = false,
      this.subScript = false,
      this.style});
}
