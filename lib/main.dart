import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/router/app_router.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/theme/theme.dart';
import 'package:focus_planner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:focus_planner/init_dependencies.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  await initDependencies();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => serviceLocator<UserCubit>()),
        BlocProvider(create: (_) => serviceLocator<AuthBloc>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final AppRouter _appRouter;

  @override
  void initState() {
    super.initState();
    _appRouter = AppRouter(userCubit: context.read<UserCubit>());
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Focus Planner',
      theme: AppTheme.darkThemeMode,
      routerConfig: _appRouter.router,
    );
  }
}
