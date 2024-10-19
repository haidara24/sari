part of 'flags_bloc.dart';

class FlagsState extends Equatable {
  const FlagsState();

  @override
  List<Object> get props => [];
}

class FlagsInitial extends FlagsState {}

class FlagsLoadingProgressState extends FlagsState {}

class FlagsLoadedSuccess extends FlagsState {
  final List<Origin> origins;

  const FlagsLoadedSuccess(this.origins);
}

class FlagsLoadedFailed extends FlagsState {
  final String error;

  const FlagsLoadedFailed(this.error);
}
