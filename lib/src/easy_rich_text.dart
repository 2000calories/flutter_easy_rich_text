import 'dart:ui';
import 'dart:ui' as ui show BoxHeightStyle, BoxWidthStyle;

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'easy_rich_text_pattern.dart';

class EasyRichText extends StatelessWidget {
  ///The orginal text
  final String text;

  ///The list of target strings and their styles.
  final List<EasyRichTextPattern>? patternList;

  ///The default text style.
  final TextStyle? defaultStyle;

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
  final TextDirection? textDirection;

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
  final int? maxLines;

  /// Used to select a font when the same Unicode character can
  /// be rendered differently, depending on the locale.
  ///
  /// It's rarely necessary to set this property. By default its value
  /// is inherited from the enclosing app with `Localizations.localeOf(context)`.
  ///
  /// See [RenderParagraph.locale] for more information.
  final Locale? locale;

  /// {@macro flutter.painting.textPainter.strutStyle}
  final StrutStyle? strutStyle;

  /// {@macro flutter.widgets.text.DefaultTextStyle.textWidthBasis}
  final TextWidthBasis textWidthBasis;

  ///case sensitive match
  ///default true
  final bool caseSensitive;

  /// If multiLine is enabled, then ^ and $ will match the beginning and end of a line, in addition to matching beginning and end of input, respectively.
  final bool multiLine;

  /// If dotAll is enabled, then the . pattern will match all characters, including line terminators.
  final bool dotAll;

  /// If unicode is enabled, then the pattern is treated as a Unicode pattern as described by the ECMAScript standard.
  final bool unicode;

  ///selectable text, default false
  final bool selectable;

  ///toolbar options for selectable text
  final Widget Function(BuildContext, EditableTextState)? contextMenuBuilder;

  ///selection controls for selectable text
  final TextSelectionControls? selectionControls;

  ///scroll physics for selectable text
  final ScrollPhysics? scrollPhysics;

  ///text height behavior for selectable text
  final TextHeightBehavior? textHeightBehavior;

  ///interactive selection control for selectable text
  final bool enableInteractiveSelection;

  ///autofocus for selectable text
  final bool autofocus;

  ///cursor radius for selectable text
  final Radius? cursorRadius;

  ///drag start behavior for selectable text
  final DragStartBehavior dragStartBehavior;

  ///on selection change function for selectable text
  final SelectionChangedCallback? onSelectionChanged;

  ///selection height style for selectable text
  final BoxHeightStyle selectionHeightStyle;

  ///selection width style for selectable text
  final BoxWidthStyle selectionWidthStyle;

  ///min lines for selectable text
  final int? minLines;

  ///cursor height for selectable text
  final double? cursorHeight;

  ///cursor width for selectable text
  final double cursorWidth;

  ///cursor color for selectable text
  final Color? cursorColor;

  ///focus node for selectable text
  final FocusNode? focusNode;

  ///semantics label for selectable text
  final String? semanticsLabel;

  ///show cursor control for selectable text
  final bool showCursor;

  /// The color to use when painting the selection.
  ///
  /// This is ignored if [SelectionContainer.maybeOf] returns null
  /// in the [BuildContext] of the [Text] widget.
  ///
  /// If null, the ambient [DefaultSelectionStyle] is used (if any); failing
  /// that, the selection color defaults to [DefaultSelectionStyle.defaultColor]
  /// (semi-transparent grey).
  final Color? selectionColor;

  EasyRichText(this.text,
      {Key? key,
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
      this.contextMenuBuilder,
      this.selectionControls,
      this.scrollPhysics,
      this.textHeightBehavior,
      this.enableInteractiveSelection = true,
      this.autofocus = false,
      this.cursorRadius,
      this.dragStartBehavior = DragStartBehavior.start,
      this.onSelectionChanged,
      this.selectionHeightStyle = ui.BoxHeightStyle.tight,
      this.selectionWidthStyle = ui.BoxWidthStyle.tight,
      this.minLines,
      this.cursorHeight,
      this.cursorWidth = 2.0,
      this.cursorColor,
      this.focusNode,
      this.semanticsLabel,
      this.showCursor = false,
      this.multiLine = false,
      this.dotAll = false,
      this.unicode = false,
      this.selectionColor});

  _launchURL(String str) async {
    Uri url = Uri.parse(str);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  List<String> specialCharacters() {
    return '\\~[]{}#%^*+=_|<>£€•.,!’()?-\$'.split('');
  }

  TapGestureRecognizer? tapGestureRecognizerForUrls(
      String str, String urlType) {
    TapGestureRecognizer? tapGestureRecognizer;
    switch (urlType) {
      case 'web':
        if (str.substring(0, 4) != "http") {
          str = "https://$str";
        }
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL(str);
          };
        break;
      case 'email':
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL("mailto:$str");
          };
        break;
      case 'tel':
        tapGestureRecognizer = TapGestureRecognizer()
          ..onTap = () {
            _launchURL("tel:${str.replaceAll(' ', '')}");
            // In order to recognize the number, iOS requires no empty spaces.
          };
        break;
      default:
        TapGestureRecognizer();
    }
    return tapGestureRecognizer;
  }

  List<String> processStrList(
      List<EasyRichTextPattern> patternList, String temText) {
    List<String> strList = [];
    List<List<int>> positions = [];

    patternList.asMap().forEach((index, pattern) {
      String thisRegExPattern;
      String targetString = pattern.targetString;
      String stringBeforeTarget = pattern.stringBeforeTarget;
      String stringAfterTarget = pattern.stringAfterTarget;

      bool matchLeftWordBoundary = pattern.matchLeftWordBoundary;
      bool matchRightWordBoundary = pattern.matchRightWordBoundary;
      bool matchWordBoundaries = pattern.matchWordBoundaries;
      //if hasSpecialCharacters then unicode is
      bool unicode = !pattern.hasSpecialCharacters;

      String wordBoundaryStringBeforeTarget1 = "\\b";
      String wordBoundaryStringBeforeTarget2 = "\\s";
      String wordBoundaryStringAfterTarget1 = "\\s";
      String wordBoundaryStringAfterTarget2 = "\\b";

      String leftBoundary = "(?<!\\w)";
      String rightBoundary = "(?!\\w)";

      ///if any of matchWordBoundaries or matchLeftWordBoundary is false
      ///set leftBoundary = ""
      if (!matchWordBoundaries || !matchLeftWordBoundary) {
        leftBoundary = "";
        wordBoundaryStringBeforeTarget1 = "";
        wordBoundaryStringAfterTarget1 = "";
      }

      if (!matchWordBoundaries || !matchRightWordBoundary) {
        rightBoundary = "";
        wordBoundaryStringBeforeTarget2 = "";
        wordBoundaryStringAfterTarget2 = "";
      }

      bool isHan = RegExp(
        r"[\u4e00-\u9fa5]+",
        caseSensitive: caseSensitive,
        unicode: unicode,
        multiLine: multiLine,
        dotAll: dotAll,
      ).hasMatch(targetString);

      bool isArabic = RegExp(r"[\u0621-\u064A]+",
              caseSensitive: caseSensitive, unicode: unicode)
          .hasMatch(targetString);

      /// if target string is Han or Arabic character
      /// set matchWordBoundaries = false
      /// set wordBoundaryStringBeforeTarget = ""
      if (isHan || isArabic) {
        matchWordBoundaries = false;
        leftBoundary = "";
        rightBoundary = "";
        wordBoundaryStringBeforeTarget1 = "";
        wordBoundaryStringBeforeTarget2 = "";
        wordBoundaryStringAfterTarget1 = "";
        wordBoundaryStringAfterTarget2 = "";
      }

      String stringBeforeTargetRegex = "";
      if (stringBeforeTarget != "") {
        stringBeforeTargetRegex =
            "(?<=$wordBoundaryStringBeforeTarget1$stringBeforeTarget$wordBoundaryStringBeforeTarget2)";
      }
      String stringAfterTargetRegex = "";
      if (stringAfterTarget != "") {
        stringAfterTargetRegex =
            "(?=$wordBoundaryStringAfterTarget1$stringAfterTarget$wordBoundaryStringAfterTarget2)";
      }

      //modify targetString by matchWordBoundaries and wordBoundaryStringBeforeTarget settings
      thisRegExPattern =
          '($stringBeforeTargetRegex$leftBoundary$targetString$rightBoundary$stringAfterTargetRegex)';
      RegExp exp = new RegExp(
        thisRegExPattern,
        caseSensitive: caseSensitive,
        unicode: unicode,
        multiLine: multiLine,
        dotAll: dotAll,
      );
      var allMatches = exp.allMatches(temText);

      //check matchOption ['all','first','last', 0, 1, 2, 3, 10]

      int matchesLength = allMatches.length;
      List<int> matchIndexList = [];
      var matchOption = pattern.matchOption;
      if (matchOption is String) {
        switch (matchOption) {
          case 'all':
            matchIndexList = new List<int>.generate(matchesLength, (i) => i);
            break;
          case 'first':
            matchIndexList = [0];
            break;
          case 'last':
            matchIndexList = [matchesLength - 1];
            break;
          default:
            matchIndexList = new List<int>.generate(matchesLength, (i) => i);
        }
      } else if (matchOption is List<dynamic>) {
        matchOption.forEach(
          (option) {
            switch (option) {
              case 'all':
                matchIndexList =
                    new List<int>.generate(matchesLength, (i) => i);
                break;
              case 'first':
                matchIndexList.add(0);
                break;
              case 'last':
                matchIndexList.add(matchesLength - 1);
                break;
              default:
                if (option is int) matchIndexList.add(option);
            }
          },
        );
      }

      ///eg. positions = [[7,11],[26,30],]
      allMatches.toList().asMap().forEach((index, match) {
        if (matchIndexList.indexOf(index) > -1) {
          positions.add([match.start, match.end]);
        }
      });
    });
    //in some cases the sorted result is still disordered;need re-sort the 1d list;
    positions.sort((a, b) => a[0].compareTo(b[0]));

    //remove invalid positions
    List<List<int>> postionsToRemove = [];
    for (var i = 1; i < positions.length; i++) {
      if (positions[i][0] < positions[i - 1][1]) {
        postionsToRemove.add(positions[i]);
      }
    }
    postionsToRemove.forEach((position) {
      positions.remove(position);
    });

    //convert positions to 1d list
    List<int> splitPositions = [0];
    positions.forEach((position) {
      splitPositions.add(position[0]);
      splitPositions.add(position[1]);
    });
    splitPositions.add(temText.length);
    splitPositions.sort();

    splitPositions.asMap().forEach((index, splitPosition) {
      if (index != 0) {
        strList
            .add(temText.substring(splitPositions[index - 1], splitPosition));
      }
    });
    return strList;
  }

  List<InlineSpan> getTextSpanList({
    required BuildContext? context,
    required List<String>? strList,
    required List<EasyRichTextPattern>? finalTempPatternList2,
    TextStyle? subTextStyle,
  }) {
    List<InlineSpan> textSpanList = [];
    // nested pattern check
    Map<int, List<EasyRichTextPattern>> patternSubset = {};
    finalTempPatternList2!.asMap().forEach((index, pattern) {
      finalTempPatternList2.asMap().forEach((temIndex, temPattern) {
        if (index != temIndex) {
          RegExp patternExp = RegExp(
            pattern.targetString,
            caseSensitive: caseSensitive,
            unicode: unicode,
            multiLine: multiLine,
            dotAll: dotAll,
          );
          bool hasMatch = patternExp.hasMatch(temPattern.targetString);
          if (hasMatch) {
            patternSubset.update(
              temIndex,
              (value) {
                value.add(pattern);
                return value;
              },
              ifAbsent: () => [pattern],
            );
          }
        }
      });
    });

    strList!.forEach((str) {
      var inlineSpan;
      int targetIndex = -1;
      RegExpMatch? match;
      if (finalTempPatternList2.isNotEmpty) {
        finalTempPatternList2.asMap().forEach((index, pattern) {
          String targetString = pattern.targetString;

          //\$, match end
          RegExp targetStringExp = RegExp(
            '^$targetString\$',
            caseSensitive: caseSensitive,
            unicode: unicode,
            multiLine: multiLine,
            dotAll: dotAll,
          );

          RegExpMatch? tempMatch = targetStringExp.firstMatch(str);
          if (tempMatch is RegExpMatch) {
            targetIndex = index;
            match = tempMatch;
          }
        });
      }

      ///If str is targetString
      if (targetIndex > -1) {
        var pattern = finalTempPatternList2[targetIndex];
        // nested pattern check
        // ABCDE, B,C => A,B,C,DE
        if (patternSubset[targetIndex] != null) {
          List<String> subStrList =
              processStrList(patternSubset[targetIndex]!, str);
          List<InlineSpan> subTextSpanList = getTextSpanList(
            context: context,
            strList: subStrList,
            finalTempPatternList2: patternSubset[targetIndex]!,
            subTextStyle: pattern.style,
          );
          textSpanList.addAll(subTextSpanList);
        } else {
          //if str is url
          var urlType = pattern.urlType;

          if (null != pattern.matchBuilder && match is RegExpMatch) {
            inlineSpan = pattern.matchBuilder!(context!, match);
          } else if (urlType != null) {
            inlineSpan = TextSpan(
              text: str,
              recognizer: tapGestureRecognizerForUrls(str, urlType),
              style: pattern.style == null
                  ? DefaultTextStyle.of(context!).style
                  : pattern.style,
            );
          } else if (pattern.superScript && !selectable) {
            //change the target string to superscript
            inlineSpan = WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, -5),
                child: Text(
                  str,
                  textScaler: TextScaler.linear(0.7),
                  // textScaleFactor: 0.7,
                  style: pattern.style == null
                      ? DefaultTextStyle.of(context!).style
                      : pattern.style,
                ),
              ),
            );
          } else if (pattern.subScript && !selectable) {
            //change the target string to subscript
            inlineSpan = WidgetSpan(
              child: Transform.translate(
                offset: const Offset(0, 2),
                child: Text(
                  str,
                  // textScaleFactor: 0.7,
                  textScaler: TextScaler.linear(0.7),
                  style: pattern.style == null
                      ? DefaultTextStyle.of(context!).style
                      : pattern.style,
                ),
              ),
            );
          } else {
            inlineSpan = TextSpan(
              text: str,
              recognizer: pattern.recognizer,
              style: pattern.style == null
                  ? DefaultTextStyle.of(context!).style
                  : pattern.style,
            );
          }

          ///add prefix/suffix InlineSpan
          if (null != pattern.prefixInlineSpan) {
            textSpanList.add(pattern.prefixInlineSpan!);
          }
          textSpanList.add(inlineSpan);
          if (null != pattern.suffixInlineSpan) {
            textSpanList.add(pattern.suffixInlineSpan!);
          }
        }
      } else {
        inlineSpan = TextSpan(
          text: str,
          style: subTextStyle,
        );
        textSpanList.add(inlineSpan);
      }
    });
    return textSpanList;
  }

  String replaceSpecialCharacters(str) {
    String tempStr = str;
    //\[]()^*+?.$-{}|!
    specialCharacters().forEach((chr) {
      tempStr = tempStr.replaceAll(chr, '\\$chr');
    });

    return tempStr;
  }

  @override
  Widget build(BuildContext context) {
    String temText = text;
    List<EasyRichTextPattern> tempPatternList =
        patternList ?? <EasyRichTextPattern>[];
    List<EasyRichTextPattern> finalTempPatternList = [];
    List<EasyRichTextPattern> finalTempPatternList2 = [];
    List<String> strList = [];
    // ignore: unused_local_variable
    bool unicode = true;

    if (tempPatternList.isEmpty) {
      strList = [temText];
    } else {
      tempPatternList.asMap().forEach((index, pattern) {
        ///if targetString is a list
        if (pattern.targetString is List<String>) {
          pattern.targetString.asMap().forEach((index, eachTargetString) {
            finalTempPatternList
                .add(pattern.copyWith(targetString: eachTargetString));
          });
        } else {
          finalTempPatternList.add(pattern);
        }
      });

      finalTempPatternList.asMap().forEach((index, pattern) {
        if (pattern.hasSpecialCharacters) {
          unicode = false;
          String newTargetString =
              replaceSpecialCharacters(pattern.targetString);
          finalTempPatternList2
              .add(pattern.copyWith(targetString: newTargetString));
        } else {
          finalTempPatternList2.add(pattern);
        }
      });

      strList = processStrList(finalTempPatternList2, temText);
    }

    List<InlineSpan> textSpanList = getTextSpanList(
      context: context,
      strList: strList,
      finalTempPatternList2: finalTempPatternList2,
    );

    if (selectable) {
      return SelectableText.rich(
        TextSpan(
            style: defaultStyle == null
                ? DefaultTextStyle.of(context).style
                : defaultStyle,
            children: textSpanList),
        scrollPhysics: scrollPhysics,
        contextMenuBuilder: contextMenuBuilder,
        maxLines: maxLines,
        strutStyle: strutStyle,
        textAlign: textAlign,
        textDirection: textDirection,
        // textScaleFactor: textScaleFactor,
        textScaler: TextScaler.linear(textScaleFactor),
        textWidthBasis: textWidthBasis,
        selectionControls: selectionControls,
        textHeightBehavior: textHeightBehavior,
        enableInteractiveSelection: enableInteractiveSelection,
        autofocus: autofocus,
        cursorRadius: cursorRadius,
        dragStartBehavior: dragStartBehavior,
        onSelectionChanged: onSelectionChanged,
        selectionHeightStyle: selectionHeightStyle,
        selectionWidthStyle: selectionWidthStyle,
        minLines: minLines,
        cursorHeight: cursorHeight,
        cursorColor: cursorColor,
        cursorWidth: cursorWidth,
        focusNode: focusNode,
        semanticsLabel: semanticsLabel,
        showCursor: showCursor,
      );
    } else {
      return Text.rich(
        TextSpan(
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
        // textScaleFactor: textScaleFactor,
        textScaler: TextScaler.linear(textScaleFactor),
        textWidthBasis: textWidthBasis,
        selectionColor: selectionColor,
      );
    }
  }
}
