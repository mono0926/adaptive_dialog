## 0.7.4

- Add `shrinkWrap` to `showConfirmationDialog` and it is defaults to `true`, which is opposite of the default value of ListView

## 0.7.3

- Support autovalidate for showTextInputDialog

## 0.7.2

- Support validation for showTextInputDialog
- Fix destructive color of showTextInputDialog for Cupertino 

## 0.7.1

- User showModal instead of showDialog for showTextInputDialog

## 0.7.0

- Delete `showDialog2020` function
  - the `configuration` parameter of [animations](https://pub.dev/packages/animations) `showModal` can be omitted at v1.1.0 so, `showDialog2020` no longer the point of existence.

## 0.6.4

- Override `textScaleFactor` to keep larger than 1 for `CupertinoActionSheet`

## 0.6.3

- Add `actionsOverflowDirection` to `showAlertDialog`
  - Only works for Material style

## 0.6.2

- Fix `showTextAnswerDialog` retry

## 0.6.1

- Fix `showConfirmationDialog` message text alignment

## 0.6.0

- Add `showConfirmationDialog`
  - Show [confirmation dialog](https://material.io/components/dialogs#confirmation-dialog), whose appearance is adaptive according to platform
  - For Cupertino, fallback to ActionSheet

## 0.5.0

- Add `materialConfiguration` to `showModalBottomSheet`
  - This suppresses many actions (long list) sheet from overflow

## 0.4.0

- Support nested navigator
  - Expose `useRootNavigator`
  - It works fine without specifying `useRootNavigator` in most cases
  - Check [example/lib/nested_navigator_page.dart](https://github.com/mono0926/adaptive_dialog/blob/master/example/lib/pages/nested_navigator_page.dart)

## 0.3.1

- Add `showDialog2020`, which wraps `showModal` with `FadeScaleTransitionConfiguration()`.

## 0.3.0

- Use `showModal` with `FadeScaleTransitionConfiguration` of [animations](https://pub.dev/packages/animations) for Material alert dialog

## 0.2.2

- Fix showTextAnswerDialog

## 0.2.1

- Add isDestructiveAction to showTextInputDialog and showTextAnswerDialog

## 0.2.0

- Add showTextInputDialog
- Add showTextAnswerDialog

## 0.1.2

- Change SheetAction's icon to nullable

## 0.1.1

- Add documentation
- Change some parameters to nullable

## 0.1.0

- Initial release