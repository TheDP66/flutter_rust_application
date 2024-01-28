import 'package:flutter/material.dart';

class ButtonFullWidth extends StatelessWidget {
  const ButtonFullWidth({super.key, this.onPressed, this.style, this.child});

  final void Function()? onPressed;
  final ButtonStyle? style;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: style?.merge(
        ElevatedButton.styleFrom(
          minimumSize: const Size.fromHeight(50),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
