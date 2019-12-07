# extended_rich_text

The EasyRichText widget provides a easy way to use RichText when you want to use specific style for specific word pattern.

This widget split string into multiple TextSpan by defining a List of EasyRichTextPattern();

The EasyRichTextPattern is a class defines the text pattern you want to format.

## Getting Started

### Installing:

```yaml
dependencies:
  easy_rich_text: '^0.2.0'
```



#### Simple example:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/simple.png)

```dart
String str1 = "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. ";

EasyRichText(
  str1,
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
```

#### Default Style:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/default%20style.png)

```dart
String str2 = "This is a EasyRichText example with default grey font. I want blue font here.";

EasyRichText(
  str2,
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
```

#### superscript and subscript.

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/superscript.png)

```dart
String str3 = "This is a EasyRichText example. I want blue superscript font here. I want no blue font here";

EasyRichText(
  str3,
  patternList: [
    EasyRichTextPattern(
        targetString: 'blue',
        stringBeforeTarget: 'want',
        style: TextStyle(color: Colors.blue),
        superScript: true),
  ],
  textAlign: TextAlign.justify,
),
```

#### All RichText properties accessible: textAlign, maxLines, overflow, etc.

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/rich%20text%20overflow.png)

```dart
String str4 = "This is a EasyRichText example. I want blue font here. TextOverflow.ellipsis, TextAlign.justify, maxLines: 1";

EasyRichText(
  str4,
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
```

#### Known issues

##### Conflict when one target string is included in another target string

```dart
String str6 = "This is a EasyRichText example. I want whole sentence blue. I want whole sentence bold.";

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
```

##### not all characters support superscript and subscript
Characters do not support superscript: q z C F Q S X Y Z
Only these characters support subscript: e h i j k l m n o p r s t u v x
  