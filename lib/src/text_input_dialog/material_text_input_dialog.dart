import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';

class MaterialTextInputDialog extends StatefulWidget {
  const MaterialTextInputDialog({
    @required this.textFields,
    this.title,
    this.message,
    this.okLabel,
    this.cancelLabel,
    this.isDestructiveAction = false,
    this.style = AdaptiveStyle.adaptive,
    this.actionsOverflowDirection = VerticalDirection.up,
    this.useRootNavigator = true,
  });
  @override
  _MaterialTextInputDialogState createState() =>
      _MaterialTextInputDialogState();

  final List<DialogTextField> textFields;
  final String title;
  final String message;
  final String okLabel;
  final String cancelLabel;
  final bool isDestructiveAction;
  final AdaptiveStyle style;
  final VerticalDirection actionsOverflowDirection;
  final bool useRootNavigator;
}

class _MaterialTextInputDialogState extends State<MaterialTextInputDialog> {
  List<TextEditingController> _textControllers;
  final _formKey = GlobalKey<FormState>();
  var _autovalidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();

    _textControllers = widget.textFields
        .map((tf) => TextEditingController(text: tf.initialText))
        .toList();
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
    void pop() => navigator.pop(
          _textControllers.map((c) => c.text).toList(),
        );
    void cancel() => navigator.pop();
    final titleText = widget.title == null ? null : Text(widget.title);
    final okText = Text(
      widget.okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
      style: TextStyle(
        color: widget.isDestructiveAction ? colorScheme.error : null,
      ),
    );
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: titleText,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.message != null)
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Scrollbar(
                    child: SingleChildScrollView(
                      child: Text(widget.message),
                    ),
                  ),
                ),
              ),
            ..._textControllers.mapWithIndex((c, i) {
              final textField = widget.textFields[i];
              return TextFormField(
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
              );
            })
          ],
        ),
        actions: [
          TextButton(
            child: Text(
              widget.cancelLabel ??
                  MaterialLocalizations.of(context).cancelButtonLabel,
            ),
            onPressed: cancel,
          ),
          TextButton(
            child: okText,
            onPressed: () {
              if (_formKey.currentState.validate()) {
                pop();
              } else if (_autovalidateMode == AutovalidateMode.disabled) {
                setState(() {
                  _autovalidateMode = AutovalidateMode.always;
                });
              }
            },
          )
        ],
        actionsOverflowDirection: widget.actionsOverflowDirection,
      ),
    );
  }
}
