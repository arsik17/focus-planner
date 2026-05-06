import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/widgets/loader.dart';
import 'package:focus_planner/features/stats/presentation/cubit/stats_cubit.dart';
import 'package:focus_planner/features/stats/presentation/cubit/stats_state.dart';
import 'package:focus_planner/features/stats/presentation/widgets/completion_card.dart';
import 'package:focus_planner/features/stats/presentation/widgets/streak_section.dart';
import 'package:focus_planner/features/stats/presentation/widgets/weekly_chart_card.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key});

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<StatsCubit>().loadStats();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress'),
        centerTitle: true,
      ),
      body: BlocBuilder<StatsCubit, StatsState>(
        builder: (context, state) {
          if (state.status == StatsStatus.loading) {
            return const Loader();
          }

          if (state.status == StatsStatus.failure) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Failed to load stats',
                style: const TextStyle(color: Colors.white54),
              ),
            );
          }

          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              CompletionCard(
                completed: state.completedTasks,
                total: state.totalTasks,
              ),
              const SizedBox(height: 24),
              StreakSection(
                currentStreak: state.currentStreak,
                totalSessions: state.totalSessions,
                totalMinutes: state.totalFocusMinutes,
              ),
              const SizedBox(height: 24),
              WeeklyChartCard(
                topCategoryName: state.topCategoryName,
                weeklyMinutes: state.weeklyFocusMinutes,
              ),
              const SizedBox(height: 80),
            ],
          );
        },
      ),
    );
  }
}
