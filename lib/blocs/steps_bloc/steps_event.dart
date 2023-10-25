part of 'steps_bloc.dart';

abstract class StepsEvent extends Equatable {
  const StepsEvent();

  @override
  List<Object> get props => [];
}

class StepsCountChangedEvent extends StepsEvent {
  final StepCount stepCount;

  const StepsCountChangedEvent(this.stepCount);
}

class StepsCountErrorEvent extends StepsEvent {
  final dynamic error;

  const StepsCountErrorEvent(this.error);
}
