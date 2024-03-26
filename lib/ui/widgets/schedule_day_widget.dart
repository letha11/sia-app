import 'package:flutter/material.dart';
import 'package:sia_app/ui/widgets/subject_tile_item.dart';

class ScheduleDayWidget extends StatelessWidget {
  const ScheduleDayWidget({
    super.key,
    required this.day,
    required this.children,
  });

  final String day;
  final List<SubjectTileItem> children;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      clipBehavior: Clip.antiAlias,
      borderRadius: BorderRadius.circular(6),
      child: Material(
        color: Theme.of(context).colorScheme.primary,
        child: ExpansionTile(
          title: Text(
            day,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
          iconColor: Theme.of(context).colorScheme.onPrimary,
          collapsedIconColor: Theme.of(context).colorScheme.onPrimary,
          shape: const Border(),
          collapsedShape: const Border(),
          dense: true,
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(15, 20, 15, 10),
              color: const Color(0xFFF4F4F4),
              child: Column(
                children: children,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
