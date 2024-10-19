import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/models/user_model.dart';
import 'package:custome_mobile/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';

part 'broker_list_event.dart';
part 'broker_list_state.dart';

class BrokerListBloc extends Bloc<BrokerListEvent, BrokerListState> {
  late AuthRepository authRepository;
  BrokerListBloc({required this.authRepository}) : super(BrokerListInitial()) {
    on<BrokerListLoadEvent>((event, emit) async {
      emit(BrokerListLoadingProgress());
      try {
        var brokers = await authRepository.getCostumBrokers();
        emit(BrokerListSucess(brokers));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
