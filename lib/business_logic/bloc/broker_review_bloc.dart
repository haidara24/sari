import 'package:bloc/bloc.dart';
import 'package:custome_mobile/data/repositories/auth_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:custome_mobile/data/models/user_model.dart';

part 'broker_review_event.dart';
part 'broker_review_state.dart';

class BrokerReviewBloc extends Bloc<BrokerReviewEvent, BrokerReviewState> {
  late AuthRepository authRepository;
  BrokerReviewBloc({required this.authRepository})
      : super(BrokerReviewInitial()) {
    on<BrokerReviewLoadEvent>((event, emit) async {
      emit(BrokerReviewLoadingProgress());
      try {
        var reviews = await authRepository.getreviews(event.brokerId);
        emit(BrokerReviewSucess(reviews));
        // ignore: empty_catches
      } catch (e) {}
    });
  }
}
