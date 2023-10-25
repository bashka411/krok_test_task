part of 'steps_bloc.dart';

enum StepsStatus {
  initial,
  available,
  unavailable,
}

class StepsState extends Equatable {
  final int stepCount;
  final StepsStatus stepsStatus;

  const StepsState({
    required this.stepCount,
    this.stepsStatus = StepsStatus.available,
  });

  const StepsState.initial()
      : stepCount = 0,
        stepsStatus = StepsStatus.initial;

  const StepsState.unavailable()
      : stepCount = 0,
        stepsStatus = StepsStatus.unavailable;

  @override
  List<Object> get props => [stepCount];
}
