// ignore_for_file: unnecessary_string_escapes

import 'package:easy_rich_text/easy_rich_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyRichText Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'EasyRichText Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                //trademark example
                EasyRichText(
                  "ProductTM is a superscript trademark symbol. This TM is not a trademark.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'TM',
                      superScript: true,
                      stringBeforeTarget: 'Product',
                      matchWordBoundaries: false,
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                //simple example
                EasyRichText(
                  "I want blue font. I want bold font. I want italic font.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'italic',
                      style: const TextStyle(fontStyle: FontStyle.italic),
                    ),
                    EasyRichTextPattern(
                      targetString: 'blue',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    EasyRichTextPattern(
                      targetString: 'bold',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),

                ///list of targetString have same text decoration.
                EasyRichText(
                  "bold1 TEST bold2 TEST bold3",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: ['bold1', 'bold2', 'bold3'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),

                //default style
                EasyRichText(
                  "This is a EasyRichText example with default grey font. I want blue font here.",
                  defaultStyle: const TextStyle(color: Colors.grey),
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'blue',
                      style: const TextStyle(color: Colors.blue),
                    ),
                    EasyRichTextPattern(
                      targetString: 'bold',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                //superscript and subscript
                EasyRichText(
                  "I want superscript font here. I wantp subscript here",
                  patternList: [
                    EasyRichTextPattern(
                        targetString: 'superscript', superScript: true),
                    EasyRichTextPattern(
                        targetString: 'subscript', subScript: true),
                  ],
                ),
                //conditional match
                EasyRichText(
                  "I want blue color here. I want no blue font here. I want blue invalid here.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'blue',
                      stringBeforeTarget: 'want',
                      stringAfterTarget: "color",
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),
                //matchOption can be a string or a list
                //string: 'all', 'first', 'last'
                //List<dynamic>:'first', 'last', and any integer index
                //For example, [0, 1, 'last'] will match the first, second, and last one.
                EasyRichText(
                  "blue 1, blue 2, blue 3, blue 4, blue 5",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'blue',
                      //matchOption: 'all'
                      matchOption: [0, 1, 'last'],
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),

                //All RichText properties accessible
                EasyRichText(
                  "TextOverflow.ellipsis, TextAlign.justify, maxLines: 1. TextOverflow.ellipsis, TextAlign.justify, maxLines: 1.",
                  textAlign: TextAlign.justify,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),

                //regular expression
                EasyRichText(
                  "Regular Expression. I want blue bluea blue1 but not blueA",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'bl[a-z0-9]*',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),

                //case insensitivity
                EasyRichText(
                  "Case-Insensitive String Matching. I want both Blue and blue.",
                  caseSensitive: false,
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'Blue',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),

                //selectable.
                EasyRichText(
                  "This paragraph is selectable...",
                  selectable: true,
                ),

                ///urls, will disable superscript and subscript
                EasyRichText(
                  "Here is a website https://pub.dev/packages/easy_rich_text. Here is a email address test@example.com. Here is a telephone number +852 12345678.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'https://pub.dev/packages/easy_rich_text',
                      urlType: 'web',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    EasyRichTextPattern(
                      targetString: EasyRegexPattern.emailPattern,
                      urlType: 'email',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    EasyRichTextPattern(
                      targetString: EasyRegexPattern.webPattern,
                      urlType: 'web',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    EasyRichTextPattern(
                      targetString: EasyRegexPattern.telPattern,
                      urlType: 'tel',
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),

                ///GestureRecognizer, not working when superscript, subscript, or urlType is set.
                ///TapGestureRecognizer, MultiTapGestureRecognizer, etc.
                EasyRichText(
                  "Tap recognizer to print this sentence.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'recognizer',
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          // ignore: avoid_print
                          print("Tap recognizer to print this sentence.");
                        },
                      style: const TextStyle(
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),

                //if the targetString contains the following special characters \[]()^*+?
                EasyRichText(
                  "Received 88+ messages. Received 99+ messages ()",
                  patternList: [
                    //set hasSpecialCharacters to true
                    EasyRichTextPattern(
                      targetString: '99+',
                      hasSpecialCharacters: true,
                      style: const TextStyle(color: Colors.blue),
                    ),
                    //or if you are familiar with regular expressions, then use \\ to skip it
                    EasyRichTextPattern(
                      targetString: '88\\+',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),

                ///WhatsApp like text formatter
                EasyRichText(
                  "what are *you* doing *and* hi ~hey~. _italic_ ",
                  defaultStyle: const TextStyle(color: Colors.white),
                  patternList: [
                    ///bold font
                    EasyRichTextPattern(
                      targetString: '(\\*)(.*?)(\\*)',
                      matchBuilder: (BuildContext context, RegExpMatch? match) {
                        // print(match[0]);
                        return TextSpan(
                          text: match?[0]?.replaceAll('*', ''),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        );
                      },
                    ),

                    ///italic font
                    EasyRichTextPattern(
                      targetString: '(\_)(.*?)(\_)',
                      matchBuilder: (BuildContext context, RegExpMatch? match) {
                        // print(match[0]);
                        return TextSpan(
                          text: match?[0]?.replaceAll('_', ''),
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        );
                      },
                    ),

                    ///strikethrough
                    EasyRichTextPattern(
                      targetString: '(\~)(.*?)(\~)',
                      matchBuilder: (BuildContext context, RegExpMatch? match) {
                        // print(match[0]);
                        return TextSpan(
                          text: match?[0]?.replaceAll('~', ''),
                          style: const TextStyle(
                              decoration: TextDecoration.lineThrough),
                        );
                      },
                    ),
                  ],
                ),

                ///add icon before/after targetString
                EasyRichText(
                  "Please contact us at +123456789",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: EasyRegexPattern.telPattern,
                      prefixInlineSpan: const WidgetSpan(
                        child: Icon(Icons.local_phone),
                      ),
                      suffixInlineSpan: const WidgetSpan(
                        child: Icon(Icons.local_phone),
                      ),
                    )
                  ],
                ),

                //Chinese Character
                EasyRichText(
                  "I want 世界你好 here. I want not 世界你好 font here.",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: '世界',
                      stringBeforeTarget: 'want ',
                      style: const TextStyle(color: Colors.blue),
                    ),
                  ],
                ),

                //Arabic Character
                EasyRichText(
                  "الحياة أكثر من مجرد الحاضر",
                  patternList: [
                    EasyRichTextPattern(
                      targetString: 'من',
                      style: const TextStyle(color: Colors.blue),
                    )
                  ],
                  defaultStyle: const TextStyle(color: Colors.red),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
