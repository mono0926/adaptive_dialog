## 1.9.0+1

- Adds pub topics and screenshots to package metadata.

## 1.9.0

- Support Flutter 3.10
- Upgrade macos_ui to 2.0.0

## 1.9.0-x-macos-beta.1

- Follow changes of macos_ui 2.0.0-beta.7

## 1.9.0-x-macos-beta.0

- Depends on macos_ui again

## 1.9.0-no-macos.3

- fix: pop with dialog context (#115)

## 1.9.0-no-macos.2

- Fix Flutter 3.10 compile error caused by macos_ui package
  - Remove [macos_ui](https://pub.dev/packages/macos_ui) dependency temporarily and show same UI as iOS instead
  - Upon stable release, the UI that uses the original macos_ui will be restored

## 1.8.3

- Fix no title `showModalActionSheet` for Material style

## 1.8.2

- Fix the error with `pop` when `BuildContext` is disposed

## 1.8.1+1

- Add documentation about `barrierDismissible`

## 1.8.1

- Add `@useResult` to each functions

## 1.8.0

- Support textCapitalization in DialogTextField (#91)
- Fix typo (`maxLenght` → `maxLength`)

## 1.7.0

- Adde maxLength to fields (#84)
- Expose route settings on all apis (#88)

## 1.6.4

- Use accentColor for macOS by using dynamic_color
- Update min SDK version to 2.17.0

## 1.6.3

- Use macos_ui v1

## 1.6.2

- Fix `useActionSheetForIOS` was mistakenly worked

## 1.6.1

- Add outer edge to showTextInputDialog for macOS
- Support dragging text input dialog for macOS

## 1.6.0

- Support for macOS dialogs
- Add `AdaptiveDialog.instance.updateConfiguration`, a method used for changing default configuration

## 1.5.1

- Add `autocorrect` to `DialogTextField` (#63)

## 1.5.0

- Add `builder` parameter
  - This resolved #28, #42 and #56

## 1.4.0

- Change `isCupertinoStyle` to return `true` if TargetPlatform is macOS

## 1.3.0

- Deprecate `alertStyle` of `showOkAlertDialog`/`showOkCancelAlertDialog`, which was mistakenly defined, and add `style` property instead.
- Make Material style `showOkAlertDialog` scrollable (#53)

## 1.2.0

- Add `isCaseSensitive` parameter to `showTextAnswerDialog` (#49)

## 1.1.0

- Add optional arg to submit form when user hits enter on last input field to `showTextAnswerDialog()` (#39)

## 1.0.1

- Remove unused `cancelLabel` from `MaterialModalActionSheet`

## 1.0.0

- Add `onWillPop` parameter

## 0.10.0

- Migrate to null safety (https://github.com/mono0926/adaptive_dialog/issues/25)

## 0.9.4

- Fix missing `fullyCapitalizedForMaterial` (https://github.com/mono0926/adaptive_dialog/issues/23)

## 0.9.3

- Support initial selection for showConfirmationDialog
- Set toggleable true for showConfirmationDialog

## 0.9.2

- Add minLines/maxLines to DialogTextField (#12)

## 0.9.1

- Add prefixText/suffixText to DialogTextField (#11)

## 0.9.0

- Add `fullyCapitalizedForMaterial` to `showAlertDialog`
  - default: true
  - If it is true, button label is fully capitalized automatically, which is recommended at the Material Design guide.

## 0.8.0

- Use new buttons

## 0.7.5

- If there is enough height, `NeverScrollableScrollPhysics` will be set to `showConfirmationDialog`'s inner `ListView`

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
