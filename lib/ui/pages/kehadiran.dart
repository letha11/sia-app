import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/attendance/attendance_bloc.dart';
import 'package:sia_app/ui/widgets/attendance_status.dart';
import 'package:sia_app/ui/widgets/shimmer.dart';
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
      body: Shimmer(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<AttendanceBloc>().add(FetchAttendance());
          },
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
            child: BlocBuilder<AttendanceBloc, AttendanceState>(
                builder: (context, state) {
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
                    ),Padding(
                      padding: EdgeInsets.symmetric(vertical: 9),
                      child: ShimmerLoadingIndicator(
                        isLoading: true,
                        child: SubjectContainer(
                          subject: 'dummy',
                          attendance: [],
                        ),
                      ),
                    ),Padding(
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
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 9),
                      child: SubjectContainer(
                        subject: kuliah.namaMatkul!,
                        attendance:
                            List.generate(kuliah.perkuliahan!.length, (i) {
                          final perkuliahan = kuliah.perkuliahan![i];
                          // print(perkuliahan.tanggal!.day);
                          // print(perkuliahan.tanggal!.month);
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
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: Column(
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
                        style: TextStyle(fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.error),
                      ),
                    ],
                  ),
                );
              }
            }),
          ),
        ),
      ),
    );
  }
}
