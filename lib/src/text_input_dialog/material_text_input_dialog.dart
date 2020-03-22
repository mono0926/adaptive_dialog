import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:flutter/material.dart';
import 'package:adaptive_dialog/src/extensions/extensions.dart';

class MaterialTextInputDialog extends StatefulWidget {
  const MaterialTextInputDialog({
    @required this.textFields,
    this.titleLabel,
    this.okLabel,
    this.cancelLabel,
    this.messageLabel,
    this.style = AdaptiveStyle.adaptive,
  });
  @override
  _MaterialTextInputDialogState createState() =>
      _MaterialTextInputDialogState();

  final List<DialogTextField> textFields;
  final String titleLabel;
  final String okLabel;
  final String cancelLabel;
  final String messageLabel;
  final AdaptiveStyle style;
}

class _MaterialTextInputDialogState extends State<MaterialTextInputDialog> {
  List<TextEditingController> _textControllers;

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
    final navigator = Navigator.of(context);
    void pop() => navigator.pop(
          _textControllers.map((c) => c.text).toList(),
        );
    void cancel() => navigator.pop();
    final titleText =
        widget.titleLabel == null ? null : Text(widget.titleLabel);
    final okText = Text(
      widget.okLabel ?? MaterialLocalizations.of(context).okButtonLabel,
    );
    return AlertDialog(
      title: titleText,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.messageLabel != null)
            Flexible(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Scrollbar(
                  child: SingleChildScrollView(
                    child: Text(widget.messageLabel),
                  ),
                ),
              ),
            ),
          ..._textControllers.mapWithIndex((c, i) {
            final textField = widget.textFields[i];
            return TextField(
              controller: c,
              autofocus: i == 0,
              obscureText: textField.obscureText,
              decoration: InputDecoration(
                hintText: textField.hintText,
              ),
            );
          })
        ],
      ),
      actions: [
        FlatButton(
          child: Text(
            widget.cancelLabel ??
                MaterialLocalizations.of(context).cancelButtonLabel,
          ),
          onPressed: cancel,
        ),
        FlatButton(
          child: okText,
          onPressed: pop,
        )
      ],
    );
  }
}
