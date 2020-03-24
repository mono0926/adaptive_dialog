import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

Future<T> showDialog2020<T>({
  @required BuildContext context,
  bool useRootNavigator = true,
  WidgetBuilder builder,
}) {
  return showModal<T>(
    context: context,
    configuration: FadeScaleTransitionConfiguration(),
    useRootNavigator: useRootNavigator,
    builder: builder,
  );
}
