import 'package:flutter/material.dart';
import 'package:sia_app/utils/constants.dart';

class AttendanceStatusWidget extends StatelessWidget {
  const AttendanceStatusWidget({
    super.key,
    this.text,
    required this.presence,
  });

  final String? text;
  final AttendanceStatus presence;

  Color getPresenceColor() {
    if (presence == AttendanceStatus.noClassYet) {
      return Colors.white;
    } else if (presence == AttendanceStatus.present) {
      return const Color(0xFF00E0AF);
    } else {
      return const Color(0xFFE82222);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
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
              text!,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 9,
                    color: Theme.of(context).colorScheme.onPrimary,
                    height: 1.2,
                  ),
            ),
        ],
      ),
    );
  }
}
