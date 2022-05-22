import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class InvoiceState extends Equatable {
  final SBlocState? invoiceState;

  const InvoiceState({
    this.invoiceState = const SBlocState.init(),
  });

  InvoiceState copyWith({
    SBlocState? invoiceState,
  }) {
    return InvoiceState(
      invoiceState: invoiceState ?? this.invoiceState,
    );
  }

  @override
  List<Object?> get props => [
        invoiceState,
      ];
}
