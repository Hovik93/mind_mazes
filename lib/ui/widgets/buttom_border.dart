import 'package:flutter/material.dart';
import 'package:mind_mazes/base/colors.dart';

class BottomBorderContainer extends StatelessWidget {
  final Widget child;

  const BottomBorderContainer({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 0),
          ),
        ],
        border: Border(
          bottom: BorderSide(
            color: AppColors.grey1,
            width: 0.3,
          ),
        ),
      ),
      child: child,
    );
  }
}
