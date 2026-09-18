import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MacosDraggableDialog extends StatefulWidget {
  const MacosDraggableDialog({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  State<MacosDraggableDialog> createState() => _MacosDraggableDialogState();
}

class _MacosDraggableDialogState extends State<MacosDraggableDialog> {
  Offset _offset = Offset.zero;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final borderRadius = BorderRadius.circular(12);
    final isLight = theme.brightness == Brightness.light;
    final color = isLight
        ? CupertinoColors.extraLightBackgroundGray
        : CupertinoColors.darkBackgroundGray;
    final innerBorderColor = isLight
        ? Colors.white.withValues(alpha: 0.45)
        : Colors.white.withValues(alpha: 0.15);
    return Transform.translate(
      offset: _offset,
      child: Dialog(
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(
          borderRadius: borderRadius,
        ),
        backgroundColor: color,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(
              width: 2,
              color: innerBorderColor,
            ),
            borderRadius: borderRadius,
          ),
          foregroundDecoration: BoxDecoration(
            border: Border.all(
              color: isLight
                  ? Colors.black.withValues(alpha: 0.23)
                  : Colors.black.withValues(alpha: 0.76),
            ),
            borderRadius: borderRadius,
          ),
          child: SizedBox(
            width: 500,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                GestureDetector(
                  onPanUpdate: (details) => setState(() {
                    _offset += details.delta;
                  }),
                  child: Container(
                    height: 28,
                    decoration: BoxDecoration(
                      color: Color.lerp(color, Colors.white, 0.12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 1,
                        ),
                      ],
                    ),
                  ),
                ),
                widget.child,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
