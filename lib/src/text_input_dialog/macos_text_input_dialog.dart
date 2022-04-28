import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';
import 'package:collection/collection.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:macos_ui/macos_ui.dart';

class MacOSTextInputDialog extends StatefulWidget {
  const MacOSTextInputDialog({
    Key? key,
    required this.textFields,
    this.title,
    this.message,
    this.okLabel,
    this.cancelLabel,
    this.isDestructiveAction = false,
    this.style = AdaptiveStyle.adaptive,
    this.useRootNavigator = true,
    this.onWillPop,
    this.autoSubmit = false,
  }) : super(key: key);
  @override
  _MacOSTextInputDialogState createState() => _MacOSTextInputDialogState();

  final List<DialogTextField> textFields;
  final String? title;
  final String? message;
  final String? okLabel;
  final String? cancelLabel;
  final bool isDestructiveAction;
  final AdaptiveStyle style;
  final bool useRootNavigator;
  final WillPopCallback? onWillPop;
  final bool autoSubmit;
}

class _MacOSTextInputDialogState extends State<MacOSTextInputDialog> {
  late final List<TextEditingController> _textControllers = widget.textFields
      .map((tf) => TextEditingController(text: tf.initialText))
      .toList();
  String? _validationMessage;
  bool _autovalidate = false;

  @override
  void initState() {
    super.initState();

    for (final c in _textControllers) {
      c.addListener(() {
        if (_autovalidate) {
          _validate();
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _textControllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final navigator = Navigator.of(
      context,
      rootNavigator: widget.useRootNavigator,
    );
    void submit() => navigator.pop(
          _textControllers.map((c) => c.text).toList(),
        );
    void submitIfValid() {
      if (_validate()) {
        submit();
      }
    }

    final title = widget.title;
    final message = widget.message;
    void cancel() => navigator.pop();

    final icon = AdaptiveDialog.instance.macOS.applicationIcon;
    return Dialog(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: SizedBox(
        width: 500,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              // TODO(mono):
              height: 28,
              decoration: BoxDecoration(
                color: colorScheme.surface,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 1,
                    // offset: Offset(4, 8), // Shadow position
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (icon != null)
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8,
                        right: 20,
                      ),
                      child: SizedBox(
                        width: 52,
                        height: 52,
                        child: icon,
                      ),
                    ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (title != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(
                              title * 2,
                              style: theme.textTheme.titleMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        if (message != null)
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8),
                            child: Text(message * 10),
                          ),
                        const SizedBox(height: 8),
                        ..._textControllers.mapIndexed(
                          (i, c) {
                            final isLast = widget.textFields.length == i + 1;
                            final field = widget.textFields[i];
                            final prefixText = field.prefixText;
                            final suffixText = field.suffixText;
                            return Center(
                              child: FractionallySizedBox(
                                widthFactor: 0.7,
                                child: MacosTextField(
                                  controller: c,
                                  autofocus: i == 0,
                                  placeholder: field.hintText,
                                  obscureText: field.obscureText,
                                  keyboardType: field.keyboardType,
                                  minLines: field.minLines,
                                  maxLines: field.maxLines,
                                  autocorrect: field.autocorrect,
                                  prefix: prefixText == null
                                      ? null
                                      : Text(prefixText),
                                  suffix: suffixText == null
                                      ? null
                                      : Text(suffixText),
                                  // decoration: _borderDecoration(
                                  //   isTopRounded: i == 0,
                                  //   isBottomRounded: i == _textControllers.length - 1,
                                  // ),
                                  textInputAction:
                                      isLast ? null : TextInputAction.next,
                                  onSubmitted: isLast && widget.autoSubmit
                                      ? (_) => submitIfValid()
                                      : null,
                                ),
                              ),
                            );
                          },
                        ),
                        const SizedBox(height: 12),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TODO(mono): 色を改善
                            PushButton(
                              buttonSize: ButtonSize.large,
                              isSecondary: true,
                              onPressed: cancel,
                              child: Text(
                                widget.cancelLabel ??
                                    MaterialLocalizations.of(context)
                                        .cancelButtonLabel
                                        .capitalizedForce,
                              ),
                            ),
                            const SizedBox(width: 14),
                            PushButton(
                              buttonSize: ButtonSize.large,
                              isSecondary: true,
                              onPressed: submitIfValid,
                              child: Text(
                                widget.okLabel ??
                                    MaterialLocalizations.of(context)
                                        .okButtonLabel,
                                style: TextStyle(
                                  color: widget.isDestructiveAction
                                      ? CupertinoColors.systemRed
                                          .resolveFrom(context)
                                      : null,
                                ),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  bool _validate() {
    _autovalidate = true;
    final validations = widget.textFields.mapIndexed((i, tf) {
      final validator = tf.validator;
      return validator == null ? null : validator(_textControllers[i].text);
    }).where((result) => result != null);
    setState(() {
      _validationMessage = validations.join('\n');
    });
    return validations.isEmpty;
  }
}
