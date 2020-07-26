import 'package:flutter/material.dart';
import 'package:easy_rich_text/easy_rich_text.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EasyRichText Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'EasyRichText Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

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
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              //simple example
              EasyRichText(
                "I want blue font. I want bold font. I want italic font.",
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    style: TextStyle(color: Colors.blue),
                  ),
                  EasyRichTextPattern(
                    targetString: 'bold',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  EasyRichTextPattern(
                    targetString: 'italic',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ],
              ),
              //default style
              EasyRichText(
                "This is a EasyRichText example with default grey font. I want blue font here.",
                defaultStyle: TextStyle(color: Colors.grey),
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    style: TextStyle(color: Colors.blue),
                  ),
                  EasyRichTextPattern(
                    targetString: 'bold',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              //superscript and subscript
              EasyRichText(
                "I want superscript font here. I want subscript here",
                patternList: [
                  EasyRichTextPattern(
                      targetString: 'superscript', superScript: true),
                  EasyRichTextPattern(
                      targetString: 'subscript', subScript: true),
                ],
              ),
              //conditional match
              EasyRichText(
                "I want blue font here. I want not blue font here.",
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    stringBeforeTarget: 'want',
                    style: TextStyle(color: Colors.blue),
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
                    style: TextStyle(color: Colors.blue),
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
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),

              //selectable.
              EasyRichText(
                "This paragraph is selectable...",
                selectable: true,
              ),

              //Arabic text
              EasyRichText(
                "الحياة أكثر من مجرد الحاضر",
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'من مجرد',
                    style: TextStyle(color: Colors.blue),
                  )
                ],
                defaultStyle: TextStyle(color: Colors.red),
              ),

              //know issue 
              EasyRichText(
                "This is a EasyRichText example. I want whole sentence blue. I want whole sentence bold.",
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'I want whole sentence blue',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  EasyRichTextPattern(
                    targetString: 'blue',
                    style: TextStyle(color: Colors.blue),
                  ),
                  EasyRichTextPattern(
                    targetString: 'I want whole sentence bold',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
