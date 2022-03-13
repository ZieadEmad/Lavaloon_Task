import 'package:flutter/material.dart';
import 'package:lavaloon/ui_layer/helpers/constants/colors.dart';

class CachedImagePlaceholder extends StatelessWidget {
  /// Constructor
  const CachedImagePlaceholder({
    Key? key,
    required this.height,
    required this.width,
  }) : super(key: key);

  /// widget height
  final double height;

  /// widget width
  final double width;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(14),
        color: defaultColor,
      ),
      height: height,
      width: width,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Image.asset(
          'assets/icons/loading.png',
          // 'assets/images/logo.png',
          height: height,
        ),
      ),
    );
  }
}