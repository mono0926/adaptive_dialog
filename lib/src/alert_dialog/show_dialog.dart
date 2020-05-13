import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Future<T> showDialog2020<T>({
  @required BuildContext context,
  WidgetBuilder builder,
  bool useRootNavigator = true,
  bool barrierDismissible = true,
}) {
  return showModal<T>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(
      barrierDismissible: barrierDismissible,
    ),
    useRootNavigator: useRootNavigator,
    builder: builder,
  );
}
