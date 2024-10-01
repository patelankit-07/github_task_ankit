import 'package:flutter/material.dart';
import 'package:grocery_apps/utils/extensions/app_extension.dart';

import '../colors/app_colors.dart';

class ItemCard extends StatelessWidget {
  const ItemCard({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.only(left: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: grey.withOpacity(0.01), width: 2),
            borderRadius: 20.borderRadius),
        child: child,
      ),
    );
  }
}
