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
    String str1 =
        "ProductTM is a superscript trademark symbol. This TM is not a trademark.";
    String str2 =
        "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. ";
    String str3 =
        "This is a EasyRichText example with default grey font. I want blue font here.";
    String str4 =
        "This is a EasyRichText example. I want blue superscript font here. I want no blue font here";
    String str5 =
        "This is a EasyRichText example. I want blue font here. TextOverflow.ellipsis, TextAlign.justify, maxLines: 1";
    String str6 =
        "This is a EasyRichText example. I want whole sentence blue. I want whole sentence bold.";
    String str7 =
        "Case-Insensitive String Matching. I want both Blue and blue.";
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              EasyRichText(
                str1,
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
              EasyRichText(
                str2,
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
              EasyRichText(
                str3,
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
              EasyRichText(
                str4,
                patternList: [
                  EasyRichTextPattern(
                      targetString: 'blue',
                      stringBeforeTarget: 'want',
                      style: TextStyle(color: Colors.blue),
                      superScript: true),
                ],
                textAlign: TextAlign.justify,
              ),
              EasyRichText(
                str5,
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    stringBeforeTarget: 'want',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
                textAlign: TextAlign.justify,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),

              //case insensitivity
              EasyRichText(
                str7,
                caseSensitive: false,
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'Blue',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),

              //know issue
              EasyRichText(
                str6,
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    style: TextStyle(color: Colors.blue),
                  ),
                  EasyRichTextPattern(
                    targetString: 'I want whole sentence blue',
                    style: TextStyle(fontWeight: FontWeight.bold),
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
