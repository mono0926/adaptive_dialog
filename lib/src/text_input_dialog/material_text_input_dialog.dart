import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

class MaterialTextInputDialog extends StatefulWidget {
  const MaterialTextInputDialog({
    Key? key,
    required this.textFields,
    this.title,
    this.message,
    this.okLabel,
    this.cancelLabel,
    this.isDestructiveAction = false,
    this.style = AdaptiveStyle.adaptive,
    this.actionsOverflowDirection = VerticalDirection.up,
    this.useRootNavigator = true,
    this.fullyCapitalized = true,
    this.onWillPop,
    this.autoSubmit = false,
    this.textFieldPaddingForMaterial = EdgeInsets.zero,
  }) : super(key: key);
  @override
  _MaterialTextInputDialogState createState() =>
      _MaterialTextInputDialogState();

  final List<DialogTextField> textFields;
  final String? title;
  final String? message;
  final String? okLabel;
  final String? cancelLabel;
  final bool isDestructiveAction;
  final AdaptiveStyle style;
  final VerticalDirection actionsOverflowDirection;
  final bool useRootNavigator;
  final bool fullyCapitalized;
  final WillPopCallback? onWillPop;
  final bool autoSubmit;
  final EdgeInsetsGeometry textFieldPaddingForMaterial;
}

class _MaterialTextInputDialogState extends State<MaterialTextInputDialog> {
  late final List<TextEditingController> _textControllers = widget.textFields
      .map((tf) => TextEditingController(text: tf.initialText))
      .toList();
  final _formKey = GlobalKey<FormState>();
  var _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
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
    final title = widget.title;
    final message = widget.message;
    final navigator = Navigator.of(
      context,
      rootNavigator: widget.useRootNavigator,
    );
    void submit() => navigator.pop(
          _textControllers.map((c) => c.text).toList(),
        );
    void submitIfValid() {
      if (_formKey.currentState!.validate()) {
        submit();
      } else if (_autovalidateMode == AutovalidateMode.disabled) {
        setState(() {
          _autovalidateMode = AutovalidateMode.always;
        });
      }
    }

    void cancel() => navigator.pop();
    final titleText = title == null ? null : Text(title);
    final cancelLabel = widget.cancelLabel;
    final okLabel = widget.okLabel;
    final okText = Text(
      (widget.fullyCapitalized ? okLabel?.toUpperCase() : okLabel) ??
          MaterialLocalizations.of(context).okButtonLabel,
      style: TextStyle(
        color: widget.isDestructiveAction ? colorScheme.error : null,
      ),
    );
    return WillPopScope(
      onWillPop: widget.onWillPop,
      child: Form(
        key: _formKey,
        child: AlertDialog(
          title: titleText,
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (message != null)
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Scrollbar(
                      child: SingleChildScrollView(
                        child: Text(message),
                      ),
                    ),
                  ),
                ),
              ..._textControllers.mapIndexed((i, c) {
                final isLast = widget.textFields.length == i + 1;
                final textField = widget.textFields[i];
                return Padding(
                  padding: widget.textFieldPaddingForMaterial,
                  child: TextFormField(
                    controller: c,
                    autofocus: i == 0,
                    obscureText: textField.obscureText,
                    keyboardType: textField.keyboardType,
                    minLines: textField.minLines,
                    maxLines: textField.maxLines,
                    decoration: InputDecoration(
                      hintText: textField.hintText,
                      prefixText: textField.prefixText,
                      suffixText: textField.suffixText,
                    ),
                    validator: textField.validator,
                    autovalidateMode: _autovalidateMode,
                    textInputAction: isLast ? null : TextInputAction.next,
                    onFieldSubmitted: isLast && widget.autoSubmit
                        ? (_) => submitIfValid()
                        : null,
                  ),
                );
              })
            ],
          ),
          actions: [
            TextButton(
              onPressed: cancel,
              child: Text(
                (widget.fullyCapitalized
                        ? cancelLabel?.toUpperCase()
                        : cancelLabel) ??
                    MaterialLocalizations.of(context).cancelButtonLabel,
              ),
            ),
            TextButton(
              onPressed: submitIfValid,
              child: okText,
            )
          ],
          actionsOverflowDirection: widget.actionsOverflowDirection,
        ),
      ),
    );
  }
}
