import 'package:flutter/material.dart';
import 'package:sia_app/ui/widgets/schedule_day_widget.dart';
import 'package:sia_app/ui/widgets/subject_tile_item.dart';

class JadwalPage extends StatelessWidget {
  const JadwalPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jadwal',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: const SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
        child: Column(
          children: [
            ScheduleDayWidget(
              day: 'Senin',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduleDayWidget(
              day: 'Selasa',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduleDayWidget(
              day: 'Rabu',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduleDayWidget(
              day: 'Kamis',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduleDayWidget(
              day: 'Jumat',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
            SizedBox(height: 20),
            ScheduleDayWidget(
              day: 'Sabtu',
              children: [
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
                SubjectTileItem(
                  subject: 'Bahasa Inggris',
                  lecturer: 'Syafira Riani, S.Pd, M.Pd',
                  classAndTime: 'BD-401, 07:30-09:10',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
