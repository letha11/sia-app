import 'package:flutter/material.dart';

class SubjectTileItem extends StatelessWidget {
  const SubjectTileItem({
    super.key,
    required this.subject,
    required this.lecturer,
    required this.classAndTime,
  });

  final String subject;
  final String lecturer;
  final String classAndTime;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        subject,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Text(
                        lecturer,
                        style: const TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
                Flexible(
                  child: Text(
                    classAndTime,
                    style: const TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 10,
                    ),
                  ),
                )
              ],
            ),
          ),
          const Divider(
            color: Color(0xFFD9D9D9),
            height: 1,
          ),
        ],
      ),
    );
  }
}
