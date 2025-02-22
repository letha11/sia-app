import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/attendance/attendance_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/ui/widgets/attendance_status.dart';
import 'package:sia_app/ui/widgets/captcha_dialog.dart';
import 'package:sia_app/ui/widgets/shimmer.dart';
import 'package:sia_app/ui/widgets/subject_container.dart';
import 'package:sia_app/utils/constants.dart';

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
      body: Shimmer(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<AttendanceBloc>().add(FetchAttendance());
          },
          child: SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
              child: BlocConsumer<AttendanceBloc, AttendanceState>(
                  listener: (context, state) {
                if (state is! AttendanceFailed) return;
                if (state.error is! ReloginFailure) return;

                CaptchaDialog.show(
                  context: context,
                  onSuccess: () {
                    context.read<AttendanceBloc>().add(FetchAttendance());
                  },
                );
              }, builder: (context, state) {
                if (state is AttendanceLoading || state is AttendanceInitial) {
                  return const Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: ShimmerLoadingIndicator(
                          isLoading: true,
                          child: SubjectContainer(
                            subject: 'dummy',
                            attendance: [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: ShimmerLoadingIndicator(
                          isLoading: true,
                          child: SubjectContainer(
                            subject: 'dummy',
                            attendance: [],
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: ShimmerLoadingIndicator(
                          isLoading: true,
                          child: SubjectContainer(
                            subject: 'dummy',
                            attendance: [],
                          ),
                        ),
                      ),
                    ],
                  );
                } else if (state is AttendanceSuccess) {
                  final widgets = List.generate(
                    state.attendance.data!.length,
                    (i) {
                      final kuliah = state.attendance.data![i];
                      final absentNotStartedPresence = kuliah.perkuliahan!
                          .where((element) =>
                              element.kehadiran!.isAbsent ||
                              element.kehadiran!.isNoClassYet)
                          .length;
                      final presencePercentage = (kuliah.perkuliahan?.length ??
                                  0) >
                              0
                          ? '${((kuliah.perkuliahan!.length - absentNotStartedPresence) / kuliah.perkuliahan!.length * 100).round()}%'
                          : '0%';
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 9),
                        child: SubjectContainer(
                          subject: kuliah.namaMatkul!,
                          presencePercentage: presencePercentage,
                          attendance:
                              List.generate(kuliah.perkuliahan!.length, (i) {
                            final perkuliahan = kuliah.perkuliahan![i];
                            return AttendanceStatusWidget(
                              text: perkuliahan.tanggal != null
                                  ? '${perkuliahan.tanggal!.day}/${perkuliahan.tanggal!.month} Ke-${perkuliahan.pertemuan!}'
                                  : null,
                              presence: perkuliahan.kehadiran!,
                            );
                          }),
                        ),
                      );
                    },
                  );

                  /// using column because there is no need to use `ListView.builder`, it'll only add more complexity
                  return Column(
                    children: widgets,
                  );
                } else {
                  final s = state as AttendanceFailed;
                  return Column(
                    children: [
                      if (s.error != null) ...[
                        Text(
                          s.error.toString(),
                          style: Theme.of(context).textTheme.headlineSmall,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 5),
                      ],
                      Text(
                        s.errorMessage,
                        style: Theme.of(context).textTheme.bodySmall,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 3,
                      ),
                      const SizedBox(height: 9),
                      Text(
                        'Pull to Refresh',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  );
                }
              }),
            ),
          ),
        ),
      ),
    );
  }
}
