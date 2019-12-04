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
  String str =
      "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. ";
  String str2 =
      "This is a EasyRichText example. I want blue font here. I want no blue font here";
  String str3 =
      "This is a EasyRichText example. I want blue superscript font here. I want no blue font here";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              EasyRichText(
                text: str,
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
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str,
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
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str2,
                patternList: [
                  EasyRichTextPattern(
                    targetString: 'blue',
                    stringBeforeTarget: 'want',
                    style: TextStyle(color: Colors.blue),
                  ),
                ],
              ),
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str3,
                defaultStyle: TextStyle(
                  color: Colors.grey,
                ),
                patternList: [
                  EasyRichTextPattern(
                      targetString: 'blue',
                      stringBeforeTarget: 'want',
                      style: TextStyle(color: Colors.blue),
                      superScript: true),
                ],
                textAlign: TextAlign.justify,
      
              ),
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str2,
                defaultStyle: TextStyle(
                  color: Colors.grey,
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
