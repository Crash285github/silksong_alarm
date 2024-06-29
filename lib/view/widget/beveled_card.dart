import 'package:flutter/material.dart';

class BeveledCard extends StatelessWidget {
  final Widget child;
  final Color? color;
  final double borderWidth;
  final BorderRadiusGeometry borderRadius;
  final Function()? onTap;
  const BeveledCard({
    super.key,
    required this.child,
    this.color,
    this.borderWidth = .2,
    this.borderRadius = const BorderRadius.all(Radius.elliptical(16, 512)),
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final borderColor = color ?? Theme.of(context).colorScheme.primary;

    return Card(
      elevation: 4,
      shadowColor: borderColor,
      surfaceTintColor: borderColor,
      clipBehavior: Clip.antiAlias,
      shape: BeveledRectangleBorder(
        borderRadius: borderRadius,
        side: BorderSide(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        overlayColor: MaterialStatePropertyAll(borderColor.withOpacity(.2)),
        child: child,
      ),
    );
  }
}
