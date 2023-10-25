import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pedometer/pedometer.dart';

part 'steps_event.dart';
part 'steps_state.dart';

class StepsBloc extends Bloc<StepsEvent, StepsState> {
  StepsBloc() : super(const StepsState.initial()) {
    on<StepsEvent>((event, emit) {});
    on<StepsCountChangedEvent>(onStepsCountChanged);
    on<StepsCountErrorEvent>(onStepsCountError);

    late Stream<StepCount> stepCountStream;

    void initPlatformState() {
      stepCountStream = Pedometer.stepCountStream;
      stepCountStream
          .listen(
            (stepCount) => add(
              StepsCountChangedEvent(stepCount),
            ),
          )
          .onError(
            (error) => add(
              StepsCountErrorEvent(error),
            ),
          );
    }

    initPlatformState();
  }

  FutureOr<void> onStepsCountChanged(StepsCountChangedEvent event, Emitter<StepsState> emit) {
    emit(StepsState(stepCount: event.stepCount.steps));
  }

  FutureOr<void> onStepsCountError(StepsCountErrorEvent event, Emitter<StepsState> emit) {
    emit(const StepsState.unavailable());
    print('onStepCountError: ${event.error}');
  }
}
