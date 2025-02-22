import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/schedule/schedule_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/schedule.dart';
import 'package:sia_app/ui/widgets/captcha_dialog.dart';
import 'package:sia_app/ui/widgets/schedule_day_widget.dart';
import 'package:sia_app/ui/widgets/shimmer.dart';
import 'package:sia_app/ui/widgets/subject_tile_item.dart';
import 'package:sia_app/utils/constants.dart';

class JadwalPage extends StatefulWidget {
  const JadwalPage({super.key});

  @override
  State<JadwalPage> createState() => _JadwalPageState();
}

class _JadwalPageState extends State<JadwalPage> {
  String? _pickedPeriode;
  List<Period>? _period;

  Schedule? savedSchedule;

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: BlocConsumer<ScheduleBloc, ScheduleState>(
        listener: (context, state) {
          if (state is! ScheduleFailed) return;
          if (state.error is! ReloginFailure) return;

          CaptchaDialog.show(
            context: context,
            onSuccess: () {
              Period? periode =
                  _period?.firstWhere((p) => p.label == _pickedPeriode);
              context.read<ScheduleBloc>().add(
                    FetchSchedule(periode: periode?.value),
                  );
            },
          );
        },
        builder: (context, state) {
          if (state is ScheduleSuccess) {
            _period = state.schedule.periode;
            savedSchedule = state.schedule;
          }
          return Scaffold(
            appBar: AppBar(
              title: Text(
                'Jadwal',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              actions: [
                TextButton(
                  onPressed: state is ScheduleSuccess
                      ? () => _pickPeriode(context, state)
                      : null,
                  style: Theme.of(context).textButtonTheme.style,
                  child: Text(
                    _pickedPeriode ?? _period?.last.label ?? "",
                  ),
                )
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () async {
                context.read<ScheduleBloc>().add(
                      FetchSchedule(periode: _pickedPeriode),
                    );
              },
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(
                    parent: AlwaysScrollableScrollPhysics(),
                  ),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                  child: SizedBox(
                    width: double.infinity,
                    child: Column(
                      crossAxisAlignment: state is ScheduleFailed
                          ? CrossAxisAlignment.center
                          : CrossAxisAlignment.start,
                      children: _buildChildren(state),
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  _pickPeriode(BuildContext context, ScheduleState state) {
    final List<Widget> widgets = state is ScheduleSuccess
        ? state.schedule.periode.map(
            (p) {
              bool isSelected = p.label ==
                  (_pickedPeriode ?? state.schedule.periode.last.label);
              return Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    _pickedPeriode = p.label;
                    Navigator.of(context).pop();
                    context
                        .read<ScheduleBloc>()
                        .add(FetchSchedule(periode: p.value));
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 25, vertical: 15),
                    child: Center(
                      child: Text(
                        p.label,
                        style: isSelected
                            ? TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.onPrimary)
                            : null,
                      ),
                    ),
                  ),
                ),
              );
            },
          ).toList()
        : [Container()];

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => BottomSheet(
        backgroundColor: Theme.of(context).colorScheme.surface,
        onClosing: () {},
        builder: (context) => Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 35,
                height: 5,
                margin: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              ...widgets,
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildChildren(ScheduleState state) {
    if (state is ScheduleLoading && savedSchedule == null ||
        state is ScheduleInitial) {
      return [
        const ShimmerLoadingIndicator(
          isLoading: true,
          child: ScheduleDayWidget(
            day: 'dummy',
            enabled: false,
            children: [
              SubjectTileItem(
                subject: 'dummy',
                lecturer: 'dummy',
                classAndTime: 'dummy',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const ShimmerLoadingIndicator(
          isLoading: true,
          child: ScheduleDayWidget(
            day: 'dummy',
            enabled: false,
            children: [
              SubjectTileItem(
                subject: 'dummy',
                lecturer: 'dummy',
                classAndTime: 'dummy',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
        const ShimmerLoadingIndicator(
          isLoading: true,
          child: ScheduleDayWidget(
            day: 'dummy',
            enabled: false,
            children: [
              SubjectTileItem(
                subject: 'dummy',
                lecturer: 'dummy',
                classAndTime: 'dummy',
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ];
    } else if (savedSchedule != null) {
      return savedSchedule!.mataKuliah.entries
          .map(
            (m) => Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: ShimmerLoadingIndicator(
                isLoading: state is ScheduleLoading,
                child: ScheduleDayWidget(
                  day: m.key.capitalizeFirstCharacter(),
                  children: m.value
                      .map(
                        (subject) => SubjectTileItem(
                          subject: subject.namaMatkul,
                          lecturer: subject.dosen,
                          classAndTime: "${subject.ruangan}, ${subject.time}",
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
          .toList()
          .reversed
          .toList();
    } else {
      state = (state as ScheduleFailed);
      return [
        if (state.error != null) ...[
          Text(
            state.error.toString(),
            style: Theme.of(context).textTheme.headlineSmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 5),
        ],
        Text(
          state.errorMessage,
          style: Theme.of(context).textTheme.bodySmall,
          textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
          maxLines: 3,
        ),
        const SizedBox(height: 15),
        Text(
          'Pull to Refresh',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Theme.of(context).colorScheme.error),
        ),
      ];
    }
  }
}
