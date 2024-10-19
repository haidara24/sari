part of 'calculate_multi_result_dart_bloc.dart';

class CalculateMultiResultEvent extends Equatable {
  const CalculateMultiResultEvent();

  @override
  List<Object> get props => [];
}

class CalculateMultiTheResultEvent extends CalculateMultiResultEvent {
  final List<CalculateObject> object;

  const CalculateMultiTheResultEvent(this.object);
}
