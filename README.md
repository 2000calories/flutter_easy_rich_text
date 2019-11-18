# extended_rich_text

  

The EasyRichText widget provides a easy way to use RichText when you want to use specific style for specific word.

This widget split string into multiple TextSpan by defining a <pattern,TextStyle> Map;

  

## Getting Started

  

### Installing:

```yaml

dependencies:

easy_rich_text: '^0.0.2'

```

  

### Usage:
```dart
String str = "This is a EasyRichText example. I want blue font. I want bold font. I want italic font. I want whole sentence bold." ;
```
  

#### Simple example:

  

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

  

#### All RichText properties accessible:

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