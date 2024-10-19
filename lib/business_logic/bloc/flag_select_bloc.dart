import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/package_model.dart';
import 'package:equatable/equatable.dart';

part 'flag_select_event.dart';
part 'flag_select_state.dart';

class FlagSelectBloc extends Bloc<FlagSelectEvent, FlagSelectState> {
  FlagSelectBloc() : super(FlagSelectInitial()) {
    on<FlagSelectLoadEvent>((event, emit) {
      emit(FlagSelectLoadingProgress());
      Future.delayed(Duration(milliseconds: 100));
      emit(FlagSelectSuccess(origin: event.origin));
    });
  }
}
