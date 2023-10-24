import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:krok_test_task/cubits/signup/signup_cubit.dart';
import 'package:krok_test_task/repositories/auth_repository.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  static Route route() => MaterialPageRoute(builder: (context) => const SignUpPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sign Up')),
      body: BlocProvider(
        create: (_) => SignUpCubit(context.read<AuthRepository>()),
        child: const SignUpForm(),
      ),
    );
  }
}

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpCubit, SignUpState>(
      listener: (context, state) {
        if (state.status == SignUpStatus.success) {
          Navigator.of(context).pop();
        } else if (state.status == SignUpStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.errorMessage!),
            ),
          );
        }
      },
      child: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _EmailInput(),
          _PasswordInput(),
          _SignUpButton(),
        ],
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  const _EmailInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: TextFormField(
            onChanged: (email) => context.read<SignUpCubit>().emailChanged(email),
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.person_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _PasswordInput extends StatelessWidget {
  const _PasswordInput();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Container(
          margin: const EdgeInsets.all(8.0),
          child: TextFormField(
            obscureText: true,
            onChanged: (password) => context.read<SignUpCubit>().passwordChanged(password),
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: const Icon(Icons.lock_rounded),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpCubit, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status == SignUpStatus.submitting
            ? const CircularProgressIndicator()
            : ElevatedButton(
                onPressed: () => context.read<SignUpCubit>().signUpFormSubmitted(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.amber,
                  fixedSize: const Size(200, 40),
                ),
                child: const Text('Sign Up'),
              );
      },
    );
  }
}
