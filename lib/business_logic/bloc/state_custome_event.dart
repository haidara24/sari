part of 'state_custome_bloc.dart';

abstract class StateCustomeEvent extends Equatable {
  const StateCustomeEvent();

  @override
  List<Object> get props => [];
}

class StateCustomeLoadEvent extends StateCustomeEvent {}
