import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krok_test_task/blocs/app_bloc/app_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutRequestEvent());
            },
            icon: const Icon(Icons.logout_rounded),
          ),
        ],
      ),
      body: Align(
        alignment: const Alignment(0, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
                radius: 50,
                backgroundImage: user.photo != null ? NetworkImage(user.photo!) : null,
                child: user.photo == null ? const Icon(Icons.person_rounded) : null),
            const SizedBox(),
            Text(user.email ?? ''),
           
          ],
        ),
      ),
    );
  }
}
