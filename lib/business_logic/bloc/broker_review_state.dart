part of 'broker_review_bloc.dart';

class BrokerReviewState extends Equatable {
  const BrokerReviewState();

  @override
  List<Object> get props => [];
}

class BrokerReviewInitial extends BrokerReviewState {}

class BrokerReviewLoadingProgress extends BrokerReviewState {}

class BrokerReviewSucess extends BrokerReviewState {
  final List<Review> reviews;

  const BrokerReviewSucess(this.reviews);
}
