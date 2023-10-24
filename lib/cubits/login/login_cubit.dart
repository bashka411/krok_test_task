import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:krok_test_task/repositories/auth_repository.dart';

part 'login_state.dart';

class LogInCubit extends Cubit<LogInState> {
  final AuthRepository _authRepository;
  LogInCubit(this._authRepository) : super(LogInState.initial());

  void emailChanged(String value) {
    emit(
      state.copyWith(email: value, status: LogInStatus.initial),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: value, status: LogInStatus.initial),
    );
  }

  Future<void> logInWithCredentials() async {
    if (state.status == LogInStatus.submitting) return;
    emit(state.copyWith(status: LogInStatus.submitting));
    try {
      await _authRepository.logInWithEmailAndPassword(email: state.email, password: state.password);
      emit(state.copyWith(status: LogInStatus.success));
    } catch (err) {
      emit(state.copyWith(status: LogInStatus.error, errorMessage: err.toString()));
    }
  }
}
