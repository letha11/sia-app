import 'package:flutter/material.dart';
import 'package:sia_app/ui/widgets/attendance_status.dart';
import 'package:sia_app/utils/constants.dart';

class SubjectContainer extends StatelessWidget {
  const SubjectContainer({
    super.key,
    required this.subject,
    required this.attendance,
    this.presencePercentage = '0%',
  });

  final String subject;
  final String presencePercentage;
  final List<AttendanceStatusWidget> attendance;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 14),
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  subject,
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  presencePercentage,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                ),
              )
            ],
          ),
          Container(
            margin: const EdgeInsets.only(top: 4),
            width: 44,
            height: 2,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          const SizedBox(height: 13),
          Wrap(
            spacing: 15,
            runSpacing: 10,
            children: _buildAttendance(),
          ),
        ],
      ),
    );
  }

  _buildAttendance() {
    final List<Widget> widgets = [];
    if (attendance.isEmpty) {
      for (var i = 0; i < 16; i++) {
        widgets.add(AttendanceStatusWidget(
          text: i <= 6 ? '24/3 Ke-$i' : null,
          presence: AttendanceStatus.noClassYet,
        ));
      }
    } else {
      return attendance;
    }

    return widgets;
  }
}
