part of 'calculator_panel_bloc.dart';

class CalculatorPanelEvent extends Equatable {
  const CalculatorPanelEvent();

  @override
  List<Object> get props => [];
}

class FlagsPanelOpenEvent extends CalculatorPanelEvent {}

class TariffPanelOpenEvent extends CalculatorPanelEvent {}

class CalculatorPanelOpenEvent extends CalculatorPanelEvent {}

class CalculatorPanelHideEvent extends CalculatorPanelEvent {}
