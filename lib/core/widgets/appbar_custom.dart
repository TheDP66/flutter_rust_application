import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppbarCustom extends StatelessWidget implements PreferredSizeWidget {
  const AppbarCustom({
    super.key,
    required this.middle,
  });

  final Widget middle;

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SizedBox(
      height: 100,
      child: CupertinoNavigationBar(
        border: Border.all(
          color: colorScheme.background,
        ),
        middle: middle,
      ),
    );
  }
}
