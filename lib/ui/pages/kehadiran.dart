import 'package:flutter/material.dart';
import 'package:sia_app/ui/widgets/subject_container.dart';

class KehadiranPage extends StatelessWidget {
  const KehadiranPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Kehadiran',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 18),
            SubjectContainer(
              subject: 'Mobile Programming',
            ),
            SizedBox(height: 28),
            SubjectContainer(
              subject: 'Pemrograman Web asd asdas dasd as das',
            ),
            SizedBox(height: 28),
            SubjectContainer(
              subject: 'Pemrograman Web asd asdas dasd as das',
            ),
            SizedBox(height: 28),
            SubjectContainer(
              subject: 'Pemrograman Web asd asdas dasd as das',
            ),
            SizedBox(height: 18),
          ],
        ),
      ),
    );
  }
}
