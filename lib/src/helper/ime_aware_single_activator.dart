import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class const ImeAwareSingleActivator(
  super.trigger, {
  required final List<TextEditingController> textControllers,
}) extends SingleActivator {
  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) {
    if (textControllers.any((c) => c.value.composing.isValid)) {
      return false;
    }
    return super.accepts(event, state);
  }
}
