part of 'step_order_bloc.dart';

class StepOrderEvent extends Equatable {
  const StepOrderEvent();

  @override
  List<Object> get props => [];
}

class LoadSecondStep extends StepOrderEvent {
  final int customAgency;
  final int customeState;
  final String? offerType;
  final int? packagesNum;
  final int? tabalehNum;
  final int? weight;
  final int? price;
  final int? taxes;
  final String? product;
  final int? origin;
  final int? packageType;
  final int? rawMaterial;
  final int? industrial;

  const LoadSecondStep(
      this.customAgency,
      this.customeState,
      this.offerType,
      this.packagesNum,
      this.tabalehNum,
      this.weight,
      this.price,
      this.taxes,
      this.product,
      this.origin,
      this.packageType,
      this.rawMaterial,
      this.industrial);
}
