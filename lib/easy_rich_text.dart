import 'package:flutter/material.dart';

class EasyRichText extends StatelessWidget {
  final String text;
  final Map<String, TextStyle> patternMap;
  final Map<String, String> specialPatternMap;

  final TextStyle defaultStyle;

  /// How the text should be aligned horizontally.
  final TextAlign textAlign;

  /// The directionality of the text.
  ///
  /// This decides how [textAlign] values like [TextAlign.start] and
  /// [TextAlign.end] are interpreted.
  ///
  /// This is also used to disambiguate how to render bidirectional text. For
  /// example, if the [text] is an English phrase followed by a Hebrew phrase,
  /// in a [TextDirection.ltr] context the English phrase will be on the left
  /// and the Hebrew phrase to its right, while in a [TextDirection.rtl]
  /// context, the English phrase will be on the right and the Hebrew phrase on
  /// its left.
  ///
  /// Defaults to the ambient [Directionality], if any. If there is no ambient
  /// [Directionality], then this must not be null.
  final TextDirection textDirection;

  /// Whether the text should break at soft line breaks.
  ///
  /// If false, the glyphs in the text will be positioned as if there was unlimited horizontal space.
  final bool softWrap;

  /// How visual overflow should be handled.
  final TextOverflow overflow;

  /// The number of font pixels for each logical pixel.
  ///
  /// For example, if the text scale factor is 1.5, text will be 50% larger than
  /// the specified font size.
  final double textScaleFactor;

  /// An optional maximum number of lines for the text to span, wrapping if necessary.
  /// If the text exceeds the given number of lines, it will be truncated according
  /// to [overflow].
  ///
  /// If this is 1, text will not wrap. Otherwise, text will be wrapped at the
  /// edge of the box.
  final int maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle strutStyle;

  /// {@macro flutter.widgets.text.DefaultTextStyle.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  EasyRichText({
    @required this.patternMap,
    @required this.text,
    this.specialPatternMap,
    this.defaultStyle,
    this.textAlign = TextAlign.start,
    this.textDirection,
    this.softWrap = true,
    this.overflow = TextOverflow.clip,
    this.textScaleFactor = 1.0,
    this.maxLines,
    this.locale,
    this.strutStyle,
    this.textWidthBasis = TextWidthBasis.parent,
  });

  @override
  Widget build(BuildContext context) {
    ///Regex pattern
    List<String> patternList = [];
    patternMap.forEach((patternKey, patternType) {
      patternList.add('(?<=$patternKey)');
      patternList.add('(?=$patternKey)');
    });
    String patternStringAll = patternList.join('|');
    RegExp exp = new RegExp('($patternStringAll)');

    ///split text by RegExp pattern
    var strArr = text.split(exp);
    print(strArr);

    ///format text span by pattern type
    List<TextSpan> textSpanList = [];
    strArr.forEach((str) {
      if (patternMap.containsKey(str)) {
        textSpanList.add(TextSpan(text: str, style: patternMap[str]));
      } else {
        textSpanList.add(TextSpan(text: str));
      }
    });

    return RichText(
      text: TextSpan(
          style: defaultStyle == null
              ? DefaultTextStyle.of(context).style
              : defaultStyle,
          children: textSpanList),
      locale: locale,
      maxLines: maxLines,
      overflow: overflow,
      softWrap: softWrap,
      strutStyle: strutStyle,
      textAlign: textAlign,
      textDirection: textDirection,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
