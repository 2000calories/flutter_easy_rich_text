# easy_rich_text

The EasyRichText widget makes the RichText widget easy. You do not have to split the string manually.

This widget use regular expression to split the string based on the patterns defined in the list of EasyRichTextPattern.

The EasyRichTextPattern is a class defines the text pattern you want to format.

This widget would be useful when you want to apply RichText to text got from a query.

## Getting Started

### Installing:

```yaml
dependencies:
  easy_rich_text: '^0.3.3'
```

### Examples:

[Simple Example](#simple-example) |
[Trademark Example](#trademark-example) |
[Default Style](#default-style) |
[Superscript and Subscript](#superscript-and-subscript) |
[Case Sensitivity](#case-sensitivity) |
[Selectable Text](#selectable-text) |
[Regular Expression](#regular-expression) |
[All RichText Properties](#all-richtext-properties)

#### Simple Example:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/simple.png)

```dart
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
```

#### Trademark Example

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/trademark.png)

```dart
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
```

#### Default Style:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/default%20style.png)

```dart
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
```

#### Superscript and Subscript.

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/superscript_subscript.png)

```dart
EasyRichText(
  "I want superscript font here. I want subscript here",
  patternList: [
    EasyRichTextPattern(
        targetString: 'superscript', superScript: true),
    EasyRichTextPattern(
        targetString: 'subscript', subScript: true),
  ],
),
```

#### Case Sensitivity

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/case%20sensitivity.png)

```dart
EasyRichText(
  "Case-Insensitive String Matching. I want both Blue and blue. This paragraph is selectable.",
  caseSensitive: false,
  selectable: true,
  patternList: [
    EasyRichTextPattern(
      targetString: 'Blue',
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

#### Selectable Text

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/selectable.png)

```dart
EasyRichText(
  "This paragraph is selectable...",
  selectable: true,
),
```

#### Regular Expression

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/regular_expression.png)

```dart
EasyRichText(
  "Regular Expression. I want blue bluea blue1 but not blueA",
  patternList: [
    EasyRichTextPattern(
      targetString: 'bl[a-z0-9]*',
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

#### All RichText Properties

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/rich%20text%20overflow.png)

```dart
EasyRichText(
  "TextOverflow.ellipsis, TextAlign.justify, maxLines: 1. TextOverflow.ellipsis, TextAlign.justify, maxLines: 1.",
  textAlign: TextAlign.justify,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
```

### Known issues

#### Conflict when one target string is included in another target string

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/known%20issue%201.png)

```dart
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
```

#### If you find EasyRichText makes RichText easy, I would appreciate it if you can give me a star on [Github](https://github.com/2000calories/flutter_easy_rich_text) and a like on [pub.dev](https://pub.dev/packages/easy_rich_text)
