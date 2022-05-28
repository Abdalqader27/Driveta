import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class InvoiceState extends Equatable {
  final SBlocState? invoiceState;
  final SBlocState? statisticsSate;

  const InvoiceState({
    this.invoiceState = const SBlocState.init(),
    this.statisticsSate = const SBlocState.init(),
  });

  InvoiceState copyWith({
    SBlocState? invoiceState,
    SBlocState? statisticsSate,
  }) {
    return InvoiceState(
      invoiceState: invoiceState ?? this.invoiceState,
      statisticsSate: statisticsSate ?? this.statisticsSate,
    );
  }

  @override
  List<Object?> get props => [
        invoiceState,
        statisticsSate,
      ];
}
