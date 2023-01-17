---
name: Issue template
about: Please follow the issue template when create a new issue
title: "[Issue]"
labels: ''
assignees: ''

---

## 1. Show the EasyRichText widget code. `targetString` and example `text` are must.
## 2. Show the `flutter doctor` output.

### Common Issue 1 `hasSpecialCharacters`
```
//if the targetString contains the following special characters \[]()^*+?
EasyRichText(
  "Received 88+ messages. Received 99+ messages",
  patternList: [
    //solution1: set hasSpecialCharacters to true
    EasyRichTextPattern(
      targetString: '99+',
      hasSpecialCharacters: true,
      style: TextStyle(color: Colors.blue),
    ),
    //solution2: if you are familiar with regular expressions, then use \\ to skip it
    EasyRichTextPattern(
      targetString: '88\\+',
      style: TextStyle(color: Colors.blue),
    ),
  ],
),
```
