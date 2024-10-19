import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'stop_scroll_state.dart';

class StopScrollCubit extends Cubit<StopScrollState> {
  StopScrollCubit() : super(ScrollEnabled());

  void emitEnable() => emit(ScrollEnabled());
  void emitDisable() => emit(ScrollDisabled());
}
