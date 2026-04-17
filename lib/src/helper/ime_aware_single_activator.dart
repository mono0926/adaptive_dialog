import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class ImeAwareSingleActivator extends SingleActivator {
  const ImeAwareSingleActivator(
    super.trigger, {
    required this.textControllers,
  });

  final List<TextEditingController> textControllers;

  @override
  bool accepts(KeyEvent event, HardwareKeyboard state) {
    if (textControllers.any((c) => c.value.composing.isValid)) {
      return false;
    }
    return super.accepts(event, state);
  }
}
