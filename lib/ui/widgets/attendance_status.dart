import 'package:flutter/material.dart';

class AttendanceStatusWidget extends StatelessWidget {
  const AttendanceStatusWidget({
    super.key,
    this.text,
    this.presence,
  });

  final String? text;

  /// if `presence` is `true` the attendance will have a color of green
  /// if `false` it will have a color of red
  /// if `null` it will have no color (white)
  final bool? presence;

  Color getPresenceColor() {
    if (presence == null) {
      return Colors.white;
    } else if (presence!) {
      return const Color(0xFF00E0AF);
    } else {
      return const Color(0xFFE82222);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      child: Column(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: getPresenceColor(),
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(height: 6),
          if (text != null)
            Text(
              '24/3 Ke-1',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 8,
                    color: Theme.of(context).colorScheme.onPrimary,
                    height: 1.2,
                  ),
            ),
        ],
      ),
    );
  }
}
