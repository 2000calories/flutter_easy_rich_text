# extended_rich_text

  

The EasyRichText widget provides a easy way to use RichText when you want to use specific style for specific word.

This widget split string into multiple TextSpan by defining a <pattern,TextStyle> Map;

  

## Getting Started

  

### Installing:

```yaml

dependencies:
  easy_rich_text: '^0.1.0'

```

  

### Usage:
```dart
String str = "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. I want whole sentence bold." ;
```
  

#### Simple example:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/simple.png)

```dart

EasyRichText(
  text: str,
  patternMap: {
    ' bold ': TextStyle(fontWeight: FontWeight.bold),
    'I want whole sentence bold.': TextStyle(fontWeight: FontWeight.bold),
    ' blue ': TextStyle(fontWeight: FontWeight.bold, color: Colors.blue)
  },
)

```

  

#### Default Style:

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/default%20style.png)

```dart

EasyRichText(
  text: str,
  defaultStyle: TextStyle(color: Colors.grey),
  patternMap: {
    ' bold ': TextStyle(fontWeight: FontWeight.bold),
    ' blue ': TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
    ' italic ': TextStyle(fontStyle: FontStyle.italic,),
  },
),

```

  

#### All RichText properties accessible: textAlign, maxLines, overflow, etc.

![alt text](https://github.com/2000calories/flutter_easy_rich_text/blob/master/screen_shots/rich%20text%20overflow.png)


```dart

EasyRichText(
  text: str,
  defaultStyle:  TextStyle(
    color:  Colors.grey,
  ),
  patternMap: {
    ' bold ':  TextStyle(fontWeight:  FontWeight.bold),
    'I want whole sentence bold.': TextStyle(fontWeight:  FontWeight.bold),
    ' blue ':  TextStyle(fontWeight:  FontWeight.bold, color:  Colors.blue),
    ' italic ':  TextStyle(fontStyle:  FontStyle.italic,),
  },
  textAlign:  TextAlign.justify,
  maxLines:  1,
  overflow:  TextOverflow.ellipsis,
),

```