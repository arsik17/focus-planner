import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:focus_planner/core/shared/cubits/user/user_cubit.dart';
import 'package:focus_planner/core/theme/theme.dart';
import 'package:focus_planner/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:focus_planner/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:focus_planner/init_dependencies.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

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
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(AuthIsUserLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Focus Planner',
      theme: AppTheme.darkThemeMode,
      home: BlocSelector<UserCubit, UserState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, isUserLoggedIn) {
          if (isUserLoggedIn) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Focus Planner'),
                actions: [
                  IconButton(
                    icon: const Icon(Icons.logout),
                    onPressed: () {
                      context.read<AuthBloc>().add(AuthLogout());
                    },
                  ),
                ],
              ),
              body: const Center(child: Text('Logged In!')),
            );
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
