import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/transcript/transcript_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/data/models/transcript.dart';
import 'package:sia_app/ui/widgets/captcha_dialog.dart';
import 'package:sia_app/ui/widgets/shimmer.dart';

class TranscriptPage extends StatelessWidget {
  const TranscriptPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Transkrip',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      body: Shimmer(
        child: RefreshIndicator(
          onRefresh: () async {
            context.read<TranscriptBloc>().add(FetchTranscript());
          },
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(
              parent: AlwaysScrollableScrollPhysics(),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 41),
            child: BlocConsumer<TranscriptBloc, TranscriptState>(
              listener: (context, state) {
                if (state is! TranscriptFailed) return;
                if (state.error is! ReloginFailure) return;

                CaptchaDialog.show(
                  context: context,
                  onSuccess: () {
                    context.read<TranscriptBloc>().add(FetchTranscript());
                  },
                );
              },
              builder: (context, state) {
                if (state is TranscriptInitial || state is TranscriptLoading) {
                  return ShimmerLoadingIndicator(
                    isLoading: true,
                    child: Container(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height - 200,
                      decoration: BoxDecoration(
                        color: const Color(0xFFF4F4F4),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                } else if (state is TranscriptSuccess) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: const Color(0xFFF4F4F4),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Column(
                        children: [
                          TranscriptRow(
                            backgroundColor:
                                Theme.of(context).colorScheme.primary,
                            enableSeperator: false,
                          ),
                          if ((state.data.data?.isEmpty ?? false)) ...[
                            const SizedBox(height: 20),
                            Text(
                              'Tidak ada data',
                              style: Theme.of(context).textTheme.bodySmall,
                            ),
                          ] else ...[
                            for (TranscriptData transcript in state.data.data!)
                              TranscriptRow(
                                texts: [
                                  transcript.semester!,
                                  transcript.subject!,
                                  transcript.sks!,
                                  transcript.grade!,
                                ],
                              ),
                          ],
                        ],
                      ),
                    ),
                  );
                } else {
                  final s = state as TranscriptFailed;

                  return SizedBox(
                    width: double.infinity,
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
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Theme.of(context).colorScheme.error),
                        ),
                      ],
                    ),
                  );
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class TranscriptRow extends StatelessWidget {
  const TranscriptRow({
    super.key,
    this.backgroundColor = const Color(0xFFF4F4F4),
    this.enableSeperator = true,
    this.texts = const ['SMT', 'Mata Kuliah', 'SKS', 'Nilai'],
  }) : assert(texts.length == 4,
            'Texts must have 4 elements and should follow this order: SMT, Mata Kuliah, SKS, Nilai');

  final Color backgroundColor;
  final bool enableSeperator;
  final List<String> texts;

  bool get isHeader => texts.contains("SMT");

  Color _getGradeColor() {
    final grade = texts[3];
    if (grade.contains("A")) {
      return const Color(0xFF00E0AF);
    } else if (grade.contains("B")) {
      return const Color(0xFFFF9966);
    } else {
      return const Color(0xFFE82222);
    }
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (isHeader) {
      return Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: Theme.of(context).colorScheme.onPrimary,
            fontWeight: FontWeight.w500,
          );
    } else {
      return Theme.of(context).textTheme.bodySmall?.copyWith();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: enableSeperator
            ? Border(
                bottom: BorderSide(
                  color: const Color(0xFFD9D9D9),
                  width: 1,
                ),
              )
            : null,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Text(
              texts[0],
              textAlign: TextAlign.center,
              style: _getTextStyle(context),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              texts[1],
              style: _getTextStyle(context),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              texts[2],
              textAlign: TextAlign.center,
              style: _getTextStyle(context),
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              texts[3],
              textAlign: TextAlign.center,
              style: _getTextStyle(context)?.copyWith(
                color: !isHeader ? _getGradeColor() : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
