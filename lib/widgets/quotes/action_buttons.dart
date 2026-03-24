import 'package:flutter/material.dart';

class ActionCircleButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  final bool isActive;

  const ActionCircleButton({
    required this.icon,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    final background = Colors.white.withOpacity(isActive ? 0.22 : 0.14);
    final border = Colors.white.withOpacity(isActive ? 0.34 : 0.22);
    final iconColor = isActive
        ? const Color(0xFFF7F1E8)
        : const Color(0xFFF3ECE2).withOpacity(0.92);

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(999),
        child: Ink(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: background,
            border: Border.all(
              color: border,
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: iconColor,
            size: 21,
          ),
        ),
      ),
    );
  }
}