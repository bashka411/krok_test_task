import 'package:flow_builder/flow_builder.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krok_test_task/blocs/app_bloc/app_bloc.dart';
import 'package:krok_test_task/repositories/auth_repository.dart';
import 'package:krok_test_task/firebase_options.dart';
import 'package:krok_test_task/config/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  final authRepository = AuthRepository();
  runApp(MyApp(authRepository: authRepository));
}

class MyApp extends StatelessWidget {
  final AuthRepository _authRepository;
  const MyApp({required AuthRepository authRepository, super.key}) : _authRepository = authRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authRepository,
      child: BlocProvider(
        create: (context) => AppBloc(authRepository: _authRepository),
        child: Builder(builder: (context) {
          return MaterialApp(
            theme: ThemeData(
              useMaterial3: true,
              colorScheme: ColorScheme.fromSeed(
                seedColor: Colors.teal,
              ),
            ),
            home: FlowBuilder<AuthStatus>(
              state: context.select((AppBloc bloc) => bloc.state.status),
              onGeneratePages: onGenerateAppViewPages,
            ),
            debugShowCheckedModeBanner: false,
          );
        }),
      ),
    );
  }
}
