# easy_rich_text

[![pub package](https://img.shields.io/pub/v/easy_rich_text.svg)](https://pub.dev/packages/easy_rich_text) [![GitHub license](https://img.shields.io/github/license/2000calories/flutter_easy_rich_text)](https://github.com/2000calories/flutter_easy_rich_text/blob/master/LICENSE) [![GitHub stars](https://img.shields.io/github/stars/2000calories/flutter_easy_rich_text)](https://github.com/2000calories/flutter_easy_rich_text/stargazers)

The `EasyRichText` widget makes the RichText widget easy. You do not have to split the string manually.

This widget use regular expression to effectively split the string based on the patterns defined in the list of `EasyRichTextPattern`.

The `EasyRichTextPattern` is a class defines the text pattern you want to format.

`targetString` can be a `String` or a `List<String>`.

By default `matchWordBoundaries:true` is set to match the whole word. If you want to match substring in a word, set `matchWordBoundaries:false`

GestureRecognizer and url_launcher are integrated.

If you find this package useful, I would appreciate it if you can give me a star on [Github](https://github.com/2000calories/flutter_easy_rich_text) and a like on [pub.dev](https://pub.dev/packages/easy_rich_text)

## Getting Started

### Installing:

```yaml
dependencies:
  easy_rich_text: '^2.0.0'
```

### Examples:

[Simple Example](#simple-example) |
[Trademark Example](#trademark-example) |
[Default Style](#default-style) |
[Conditional Match](#conditional-match) |
[Match Option](#match-option) |
[Superscript and Subscript](#superscript-and-subscript) |
[Case Sensitivity](#case-sensitivity) |
[Selectable Text](#selectable-text) |
[Regular Expression](#regular-expression) |
[Url Launcher](#url-launcher) |
[GestureRecognizer](#gestureRecognizer) |
[All RichText Properties](#all-richtext-properties) |
[Special Characters](#special-characters) |
[WhatsApp Like Text Formatter](#whatsapp-like-text-formatter)

#### Simple Example:

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/simple.png)

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

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/trademark.png)

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

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/default%20style.png)

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

#### Conditional Match

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/conditional_match.png)

```dart
EasyRichText(
  "I want blue color here. I want no blue font here. I want blue invalid here.",
  patternList: [
    EasyRichTextPattern(
      targetString: 'blue',
      stringBeforeTarget: 'want',
      stringAfterTarget: "color",
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

#### Match Option

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/match_option.png)

##### matchOption can be a string or a list. default is 'all'.

##### string: 'all', 'first', 'last'

##### List<dynamic>:'first', 'last', and any integer index

##### For example, [0, 1, 'last'] will match the first, second, and last one.

```dart
EasyRichText(
  "blue 1, blue 2, blue 3, blue 4, blue 5",
  patternList: [
    EasyRichTextPattern(
      targetString: 'blue',
      //matchOption: 'all'
      matchOption: [0, 1, 'last'],
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

#### Superscript and Subscript.

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/superscript_subscript.png)

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

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/case%20sensitivity.png)

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

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/selectable.png)

```dart
EasyRichText(
  "This paragraph is selectable...",
  selectable: true,
),
```

#### Regular Expression

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/regular_expression.png)

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

#### Url Launcher

Integrated with url_launcher. Web url, email url, and telephone url are supported.
Set urlType : 'web', 'email', or 'tel'.
EasyRichText provides regular expression formula to match common urls.

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/urls.png)

```dart
EasyRichText(
  "Here is a website https://pub.dev/packages/easy_rich_text. Here is a email address test@example.com. Here is a telephone number +852 12345678.",
  patternList: [
    EasyRichTextPattern(
      targetString: 'https://pub.dev/packages/easy_rich_text',
      urlType: 'web',
      style: TextStyle(
        decoration: TextDecoration.underline,
      ),
    ),
    EasyRichTextPattern(
      targetString: EasyRegexPattern.emailPattern,
      urlType: 'email',
      style: TextStyle(
        decoration: TextDecoration.underline,
      ),
    ),
    EasyRichTextPattern(
      targetString: EasyRegexPattern.webPattern,
      urlType: 'web',
      style: TextStyle(
        decoration: TextDecoration.underline,
      ),
    ),
    EasyRichTextPattern(
      targetString: EasyRegexPattern.telPattern,
      urlType: 'tel',
      style: TextStyle(
        decoration: TextDecoration.underline,
      ),
    ),
  ],
),
```

#### GestureRecognizer

```dart
///GestureRecognizer, not working when superscript, subscript, or urlType is set.
///TapGestureRecognizer, MultiTapGestureRecognizer, etc.
EasyRichText(
  "Tap recognizer to print this sentence.",
  patternList: [
    EasyRichTextPattern(
      targetString: 'recognizer',
      recognizer: TapGestureRecognizer()
        ..onTap = () {
          print("Tap recognizer to print this sentence.");
        },
      style: TextStyle(
        decoration: TextDecoration.underline,
      ),
    ),
  ],
),
```

#### All RichText Properties

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/rich%20text%20overflow.png)

```dart
EasyRichText(
  "TextOverflow.ellipsis, TextAlign.justify, maxLines: 1. TextOverflow.ellipsis, TextAlign.justify, maxLines: 1.",
  textAlign: TextAlign.justify,
  maxLines: 1,
  overflow: TextOverflow.ellipsis,
),
```

#### Special Characters

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/special_characters.png)

```dart
//if the targetString contains the following special characters \[]()^*+?
EasyRichText(
  "Received 88+ messages. Received 99+ messages",
  patternList: [
    //set hasSpecialCharacters to true
    EasyRichTextPattern(
      targetString: '99+',
      hasSpecialCharacters: true,
      style: TextStyle(color: Colors.blue),
    ),
    //or if you are familiar with regular expressions, then use \\ to skip it
    EasyRichTextPattern(
      targetString: '88\\+',
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```

#### WhatsApp Like Text Formatter

![alt text](https://raw.githubusercontent.com/2000calories/flutter_easy_rich_text/master/screen_shots/WhatsApp_like_text_formatter.png)

```dart
///WhatsApp like text formatter
EasyRichText(
  "TEST *bold font*. test *boldfont*.",
  patternList: [
    ///bold font
    EasyRichTextPattern(
      targetString: '(\\*)(.*?)(\\*)',
      matchBuilder: (BuildContext context, RegExpMatch? match) {
        return TextSpan(
          text: match?[0]?.replaceAll('*', ''),
          style: const TextStyle(fontWeight: FontWeight.bold),
        );
      },
    ),
  ],
),
```

#### prefixInlineSpan & suffixInlineSpan
```dart
///add icon before/after targetString
EasyRichText(
  "Please contact us at +123456789",
  patternList: [
    EasyRichTextPattern(
      targetString: EasyRegexPattern.telPattern,
      prefixInlineSpan: WidgetSpan(
        child: Icon(Icons.local_phone),
      ),
      suffixInlineSpan: WidgetSpan(
        child: Icon(Icons.local_phone),
      ),
    )
  ],
),
```
