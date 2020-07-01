# easy_rich_text

The EasyRichText widget provides a easy way to use RichText when you want to use specific style for specific word pattern. This widget would be useful when you want to apply RichText to text get from a query. For example, highlight a company name or a product trademark.

This widget split string into multiple TextSpan by defining a List of EasyRichTextPattern();

The EasyRichTextPattern is a class defines the text pattern you want to format.

## Getting Started

### Installing:

```yaml
dependencies:
  easy_rich_text: '^0.2.4'
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

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/superscript_subscript.png)

```dart
String str3 = "This is a EasyRichText example. I want superscript font here. I want subscript here";

EasyRichText(
  str4,
  patternList: [
    EasyRichTextPattern(
        targetString: 'superscript', superScript: true),
    EasyRichTextPattern(
        targetString: 'subscript', subScript: true),
  ],
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

### Case Sensitivity (default true)

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/case%20sensitivity.png)

```dart
String str7 = "Case-Insensitive String Matching. I want both Blue and blue.";

EasyRichText(
  str7,
  caseSensitive: false,
  patternList: [
    EasyRichTextPattern(
      targetString: 'blue',
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

###  Trademark

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/trademark.png)

```dart
String str = "ProductTM is a superscript trademark symbol. This TM is not a trademark.";

EasyRichText(
  str,
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
```

#### Known issues

##### Conflict when one target string is included in another target string

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/known%20issue%201.png)

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
