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
      home: MyHomePage(title: 'Extended Rich Text Demo'),
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
      "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. I want whole sentence bold.";
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
                patternMap: {
                  ' bold ': TextStyle(fontWeight: FontWeight.bold),
                  'I want whole sentence bold.':
                      TextStyle(fontWeight: FontWeight.bold),
                  ' blue ':
                      TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
                },
              ),
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str,
                defaultStyle: TextStyle(color: Colors.grey),
                patternMap: {
                  ' bold ': TextStyle(fontWeight: FontWeight.bold),
                  ' blue ': TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                  ' italic ': TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                },
              ),
              Container(
                height: 80,
              ),
              EasyRichText(
                text: str,
                defaultStyle: TextStyle(
                  color: Colors.grey,
                ),
                patternMap: {
                  ' bold ': TextStyle(fontWeight: FontWeight.bold),
                  'I want whole sentence bold.':
                      TextStyle(fontWeight: FontWeight.bold),
                  ' blue ': TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.blue),
                  ' italic ': TextStyle(
                    fontStyle: FontStyle.italic,
                  ),
                },
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
