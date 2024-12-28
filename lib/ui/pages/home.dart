import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sia_app/bloc/attendance/attendance_bloc.dart';
import 'package:sia_app/bloc/home/home_bloc.dart';
import 'package:sia_app/bloc/schedule/schedule_bloc.dart';
import 'package:sia_app/core/failures.dart';
import 'package:sia_app/core/service_locator.dart';
import 'package:sia_app/data/models/user_detail.dart';
import 'package:sia_app/ui/pages/jadwal.dart';
import 'package:sia_app/ui/pages/kehadiran.dart';
import 'package:sia_app/ui/pages/setting.dart';
import 'package:sia_app/ui/widgets/captcha_dialog.dart';
import 'package:sia_app/ui/widgets/shimmer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  UserDetail? _userDetail;

  @override
  void initState() {
    context.read<HomeBloc>().add(FetchUserDetailEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Selamat Datang',
                  style: Theme.of(context).textTheme.bodySmall),
              BlocBuilder<HomeBloc, HomeState>(builder: (context, state) {
                if (state is HomeSuccess) {
                  _userDetail = state.userDetail;
                }
                return Text(
                  _userDetail?.nama ?? '',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                );
              }),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () async {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (ctx) => const SettingPage(),
                  ),
                );
              },
              icon: const Icon(Icons.settings),
            )
          ],
        ),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (BuildContext context, state) async {
            if (state is! HomeFailed) return;

            if (state.error is! ReloginFailure) return;

            CaptchaDialog.show(
              context: context,
              onSuccess: () => context.read<HomeBloc>().add(
                    FetchUserDetailEvent(),
                  ),
            );
          },
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<HomeBloc>().add(FetchUserDetailEvent());
            },
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(25, 15, 25, 25),
                  sliver: SliverToBoxAdapter(
                    child: BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {
                      if (state is HomeSuccess) {
                        _userDetail = state.userDetail;
                      }
                      return ShimmerLoadingIndicator(
                        isLoading: state is HomeLoading,
                        child: _buildDetailCard(state),
                      );
                    }),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  sliver: SliverGrid(
                    delegate: SliverChildListDelegate(
                      [
                        PageSelector(
                          title: 'Jadwal',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<ScheduleBloc>(
                                  create: (context) => sl<ScheduleBloc>()
                                    ..add(const FetchSchedule()),
                                  child: const JadwalPage(),
                                ),
                              ),
                            );
                          },
                          icon: Icons.calendar_month_rounded,
                        ),
                        PageSelector(
                          title: 'Kehadiran',
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider<AttendanceBloc>(
                                  create: (context) => sl<AttendanceBloc>()
                                    ..add(FetchAttendance()),
                                  child: const KehadiranPage(),
                                ),
                              ),
                            );
                          },
                          icon: Icons.check_circle_rounded,
                        ),
                      ],
                    ),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 5,
                      crossAxisSpacing: 18,
                      mainAxisSpacing: 10,
                      childAspectRatio: 0.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _buildDetailCard(HomeState state) {
    if (state is HomeFailed) {
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onSurface,
          height: 1.1,
        ),
        child: Container(
          width: double.infinity,
          height: 120,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          decoration: const BoxDecoration(
            color: Color(0xFFF4F4F4),
            borderRadius: BorderRadius.all(Radius.circular(6)),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.error != null) ...[
                Text(
                  state.error.toString(),
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 5),
              ],
              Flexible(
                child: Text(
                  state.errorMessage,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 3,
                ),
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
        ),
      );
    } else {
      return DefaultTextStyle.merge(
        style: TextStyle(
          color: Theme.of(context).colorScheme.onPrimary,
          height: 1.1,
        ),
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: const BorderRadius.all(Radius.circular(6)),
          ),
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 2,
                    child: CachedNetworkImage(
                      imageUrl: _userDetail?.pictureUrl ?? '',
                      errorListener: (err) {},
                      imageBuilder: (_, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) => const CircleAvatar(
                        backgroundImage: AssetImage('assets/images/user.png'),
                        backgroundColor: Colors.grey,
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    flex: 10,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          _userDetail?.nama ?? "",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          _userDetail?.jurusan ?? "",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                        Text(
                          "Semester ${_userDetail?.semester}",
                          style: const TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _userDetail?.nim ?? "",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'IPK ${_userDetail?.ipk} | SKS ${_userDetail?.sksTempuh}',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    }
  }
}

class PageSelector extends StatelessWidget {
  const PageSelector({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            // width: 60,
            height: 50,
            constraints: const BoxConstraints(maxWidth: 50),
            margin: const EdgeInsets.only(bottom: 4),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.circular(6),
            ),
            child: Center(
              child: Icon(
                icon,
                color: Theme.of(context).colorScheme.onPrimary,
              ),
            ),
          ),
          // const SizedBox(height: 8),
          Text(
            title,
            style: Theme.of(context).textTheme.bodySmall,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
