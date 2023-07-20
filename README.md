# adaptive_dialog

Show alert dialog or modal action sheet adaptively according to platform.

Web Demo: https://mono0926.com/adaptive_dialog/

## [showOkAlertDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showOkAlertDialog.html)

Convenient wrapper of [showAlertDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showAlertDialog.html).

| iOS                                                                                                                                  | Android                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img width="497" alt="n1" src="https://user-images.githubusercontent.com/1255062/77220730-59868800-6b86-11ea-823e-ddbcb24d4e27.png"> | <img width="497" alt="n2" src="https://user-images.githubusercontent.com/1255062/77220731-59868800-6b86-11ea-8521-293cc20b48bb.png"> |

## [showOkCancelAlertDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showOkCancelAlertDialog.html)

Convenient wrapper of [showAlertDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showAlertDialog.html).

| iOS                                                                                                                                  | Android                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img width="497" alt="n3" src="https://user-images.githubusercontent.com/1255062/77220732-5a1f1e80-6b86-11ea-8e1f-beb08e45387a.png"> | <img width="497" alt="n4" src="https://user-images.githubusercontent.com/1255062/77220733-5a1f1e80-6b86-11ea-8a2a-3f60185877a1.png"> |
| <img width="497" alt="n5" src="https://user-images.githubusercontent.com/1255062/77220734-5ab7b500-6b86-11ea-941b-7327f5302c9e.png"> | <img width="497" alt="n6" src="https://user-images.githubusercontent.com/1255062/77220736-5b504b80-6b86-11ea-9559-cab8f725d6fd.png"> |

## [showConfirmationDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showConfirmationDialog.html)

Show [Confirmation Dialog](https://material.io/components/dialogs#confirmation-dialog). For Cupertino, fallback to ActionSheet.

| iOS                                                                                                                                  | Android                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img width="497" alt="n3" src="https://user-images.githubusercontent.com/1255062/81771694-a6e7fb80-951e-11ea-89ff-9cd8a5e5074b.png"> | <img width="497" alt="n5" src="https://user-images.githubusercontent.com/1255062/81771886-2bd31500-951f-11ea-8722-ef4f61575191.png"> |

## [showModalActionSheet](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showModalActionSheet.html)

| iOS                                                                                                                                   | Android                                                                                                                               |
| ------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------- |
| <img width="497" alt="n7" src="https://user-images.githubusercontent.com/1255062/77220737-5b504b80-6b86-11ea-8f44-49568518717d.png">  | <img width="497" alt="n8" src="https://user-images.githubusercontent.com/1255062/77220738-5be8e200-6b86-11ea-9e7d-2067253e766d.png">  |
| <img width="497" alt="n9" src="https://user-images.githubusercontent.com/1255062/77220739-5c817880-6b86-11ea-88e8-b17caba6037d.png">  | <img width="497" alt="n10" src="https://user-images.githubusercontent.com/1255062/77220741-5d1a0f00-6b86-11ea-8525-120a0b3849ac.png"> |
| <img width="497" alt="n11" src="https://user-images.githubusercontent.com/1255062/77220742-5d1a0f00-6b86-11ea-9991-e1b5677eebf3.png"> | <img width="497" alt="n12" src="https://user-images.githubusercontent.com/1255062/77220743-5db2a580-6b86-11ea-9d9c-7b474a222c92.png"> |

## [showTextInputDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showTextInputDialog.html)

| iOS                                                                                                                                  | Android                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img width="516" alt="n1" src="https://user-images.githubusercontent.com/1255062/77243708-6b346200-6c50-11ea-9b54-252accd1df66.png"> | <img width="516" alt="n2" src="https://user-images.githubusercontent.com/1255062/77243709-6f607f80-6c50-11ea-8b71-a8932adc3dd7.png"> |
| <img width="516" alt="n3" src="https://user-images.githubusercontent.com/1255062/77243711-6ff91600-6c50-11ea-8458-56d75b958283.png"> | <img width="516" alt="n4" src="https://user-images.githubusercontent.com/1255062/77243712-7091ac80-6c50-11ea-8c08-be62e0999267.png"> |

## [showTextAnswerDialog](https://pub.dev/documentation/adaptive_dialog/latest/adaptive_dialog/showTextAnswerDialog.html)

Show text input dialog until answer is correct or cancelled.
This is useful for preventing very destructive action is executed mistakenly.

| iOS                                                                                                                                  | Android                                                                                                                              |
| ------------------------------------------------------------------------------------------------------------------------------------ | ------------------------------------------------------------------------------------------------------------------------------------ |
| <img width="516" alt="n5" src="https://user-images.githubusercontent.com/1255062/77243713-712a4300-6c50-11ea-81d4-75d7961d9224.png"> | <img width="516" alt="n6" src="https://user-images.githubusercontent.com/1255062/77243714-71c2d980-6c50-11ea-8bed-aa6b4dfcba0a.png"> |

---

# FAQ

## The getter `modalBarrierDismissLabel` was called on null

`adaptive_dialog` uses Cupertino-style widgets internally on iOS, so `GlobalCupertinoLocalizations.delegate` is required under certain conditions.

```dart
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      //...
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate, // This is required
      ],
    );
  }
}
```

## The input text color same with backgound when using CupertinoTextInputDialog

This fixes the problem.

```dart
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart' hide Router;

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        cupertinoOverrideTheme: const CupertinoThemeData(
          textTheme: CupertinoTextThemeData(), // This is required
        ),
      ),
    );
  }
}
```
