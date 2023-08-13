import 'package:flutter/material.dart';

class RoomItemTrait extends StatelessWidget {
  const RoomItemTrait({
    super.key,
    required this.icon,
    required this.label,
    required this.colorTrait,
  });

  final IconData icon;
  final String label;
  final Color colorTrait;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 17,
          color: colorTrait,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            color: colorTrait,
          ),
        ),
      ],
    );
  }
}
