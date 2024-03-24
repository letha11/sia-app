import 'package:flutter/material.dart';
import 'package:sia_app/ui/widgets/attendance_status.dart';

class SubjectContainer extends StatelessWidget {
  const SubjectContainer({
    super.key,
    required this.subject,
  });

  final String subject;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 25.0),
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
                padding: const EdgeInsets.only(left: .0),
                child: Text(
                  '100%',
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
            children: [
              for (var i = 0; i < 16; i++)
                AttendanceStatusWidget(
                  text: i <= 6 ? '24/3 Ke-$i' : null,
                  presence: true,
                ),
            ],
          ),
        ],
      ),
    );
  }
}
