import 'package:flutter_bloc/flutter_bloc.dart';

part 'current_step_state.dart';

class CurrentStepCubit extends Cubit<CurrentStepInitial> {
  CurrentStepCubit() : super(CurrentStepInitial(0));
  void increament() => emit(CurrentStepInitial(state.value + 1));
  void decreament() => emit(CurrentStepInitial(state.value - 1));
}
