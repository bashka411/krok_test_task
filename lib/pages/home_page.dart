// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krok_test_task/blocs/app_bloc/app_bloc.dart';
import 'package:krok_test_task/blocs/steps_bloc/steps_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hello, ${user.name}'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Stack(
              children: [
                CircleAvatar(
                    backgroundImage: user.photo != null ? NetworkImage(user.photo!) : null,
                    child: user.photo == null ? const Icon(Icons.person_rounded) : null),
                Positioned.fill(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(50),
                      onTap: () => showDialog(
                        context: context,
                        builder: ((context) => AlertDialog(
                              content: Text(
                                'Do you want to log out?',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                              actionsAlignment: MainAxisAlignment.spaceBetween,
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                    context.read<AppBloc>().add(AppLogoutRequestEvent());
                                  },
                                  child: const Text('Yes'),
                                ),
                                ElevatedButton(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('No'),
                                ),
                              ],
                            )),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => StepsBloc(),
        child: Builder(builder: (context) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BlocBuilder<StepsBloc, StepsState>(
                  builder: (context, state) {
                    if (state.stepsStatus == StepsStatus.unavailable) {
                      return const Text('Steps are unavailable');
                    }
                    return Text(
                      'Steps: ${state.stepCount.toString()}',
                      style: Theme.of(context).textTheme.headlineSmall,
                    );
                  },
                ),
                const SizedBox(width: 50),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.settings_rounded),
                      SizedBox(width: 10),
                      Text('Open App Settings'),
                    ],
                  ),
                  onPressed: () async {
                    openAppSettings();
                  },
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size(250, 40),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.lock_open_rounded),
                      SizedBox(width: 10),
                      Text('Request Permission'),
                    ],
                  ),
                  onPressed: () async {
                    PermissionStatus activityStatus = await Permission.activityRecognition.request();
                    switch (activityStatus) {
                      case PermissionStatus.granted:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Permission granted'),
                          ),
                        );
                      case PermissionStatus.denied:
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Permission denied'),
                          ),
                        );
                        return;
                      default:
                        return;
                    }
                  },
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
