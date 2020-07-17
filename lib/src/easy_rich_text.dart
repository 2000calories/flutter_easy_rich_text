import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'easy_rich_text_pattern.dart';

class EasyRichText extends StatelessWidget {
  ///The orginal text
  final String text;

  ///The list of target strings and their styles.
  final List<EasyRichTextPattern> patternList;

  ///The default text style.
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

  ///case sensitive match
  ///default true
  final bool caseSensitive;

  ///selectable text, default false
  final bool selectable;

  EasyRichText(
    this.text, {
    Key key,
    this.patternList,
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
    this.caseSensitive = true,
    this.selectable = false,
  });

  @override
  Widget build(BuildContext context) {
    ///Regex pattern
    List<String> regExPatternList = [];
    List<String> targetStringList = new List<String>();
    if (patternList != null) {
      patternList.forEach((pattern) {
        String targetString = pattern.targetString;
        targetStringList.add(targetString);
        String stringBeforeTarget = pattern.stringBeforeTarget;
        //String stringAfterTarget = pattern.stringAfterTarget;

        bool matchLeftWordBoundary = pattern.matchLeftWordBoundary;
        bool matchRightWordBoundary = pattern.matchRightWordBoundary;
        bool matchWordBoundaries = pattern.matchWordBoundaries;

        String wordBoundaryStringBeforeTarget = "\\b";

        bool isHan = RegExp(r"[\u4e00-\u9fa5]+",
                caseSensitive: caseSensitive, unicode: true)
            .hasMatch(targetString);
        /// if target string is Han character
        /// set matchWordBoundaries = false
        /// set wordBoundaryStringBeforeTarget = ""
        if (isHan) {
          matchWordBoundaries = false;
          wordBoundaryStringBeforeTarget = "";
        }

        //\\b: whole words only
        stringBeforeTarget == null
            ? regExPatternList.add(
                '(?<=${matchWordBoundaries || matchLeftWordBoundary ? '\\b' : ''}$targetString${matchWordBoundaries || matchRightWordBoundary ? '\\b' : ''})|(?=${matchWordBoundaries || matchLeftWordBoundary ? '\\b' : ''}$targetString${matchWordBoundaries || matchRightWordBoundary ? '\\b' : ''})')
            : regExPatternList.add(
                '(?<=$wordBoundaryStringBeforeTarget$stringBeforeTarget${matchWordBoundaries || matchLeftWordBoundary ? '\\s' : ''}$targetString${matchWordBoundaries || matchRightWordBoundary ? '\\b' : ''})|(?<=$wordBoundaryStringBeforeTarget$stringBeforeTarget${matchWordBoundaries ? '\\s' : ''})(?=$targetString${matchWordBoundaries || matchRightWordBoundary ? '\\b' : ''})');
      });
    }

    String patternStringAll = regExPatternList.join('|');

    RegExp exp = new RegExp('($patternStringAll)',
        caseSensitive: caseSensitive, unicode: true);

    ///split text by RegExp pattern
    var strList = text.split(exp);

    // print(strList);
    // print(patternStringAll);

    ///format text span by pattern type
    List<InlineSpan> textSpanList = [];
    strList.forEach((str) {
      int targetIndex = -1;

      targetStringList.asMap().forEach((index, targetString) {
        //\$, match end
        RegExp targetStringExp = new RegExp(
            '^$targetString\$',
            caseSensitive: caseSensitive,
            unicode: true);
        if (targetStringExp.hasMatch(str)) {
          targetIndex = index;
        }
      });

      ///If str is targetString
      if (targetIndex > -1) {
        if (patternList[targetIndex].superScript && !selectable) {
          //change the target string to superscript
          textSpanList.add(
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -5),
                child: Text(
                  str,
                  textScaleFactor: 0.7,
                  style: patternList[targetIndex].style == null
                      ? DefaultTextStyle.of(context).style
                      : patternList[targetIndex].style,
                ),
              ),
            ),
          );
        } else if (patternList[targetIndex].subScript && !selectable) {
          //change the target string to subscript
          textSpanList.add(
            WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 1),
                child: Text(
                  str,
                  textScaleFactor: 0.7,
                  style: patternList[targetIndex].style == null
                      ? DefaultTextStyle.of(context).style
                      : patternList[targetIndex].style,
                ),
              ),
            ),
          );
        } else {
          textSpanList.add(TextSpan(
              text: str,
              style: patternList[targetIndex].style == null
                  ? DefaultTextStyle.of(context).style
                  : patternList[targetIndex].style));
        }
      } else {
        textSpanList.add(TextSpan(text: str));
      }
    });

    if (selectable) {
      return SelectableText.rich(
        TextSpan(
            style: defaultStyle == null
                ? DefaultTextStyle.of(context).style
                : defaultStyle,
            children: textSpanList),
        maxLines: maxLines,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        textScaleFactor: textScaleFactor,
        textWidthBasis: textWidthBasis,
      );
    } else {
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
}
