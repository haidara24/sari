part of 'state_custome_bloc.dart';

abstract class StateCustomeState extends Equatable {
  const StateCustomeState();

  @override
  List<Object> get props => [];
}

class StateCustomeInitial extends StateCustomeState {}

class StateCustomeLoadingProgress extends StateCustomeState {}

class StateCustomeLoadedSuccess extends StateCustomeState {
  final List<StateCustome> states;

  const StateCustomeLoadedSuccess(this.states);
}

class StateCustomeLoadedFailed extends StateCustomeState {
  final String errortext;

  const StateCustomeLoadedFailed(this.errortext);
}
