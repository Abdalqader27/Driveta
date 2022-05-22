import 'package:core/core.dart';

import '../../../domain/use_cases/invoice_usecase.dart';
import 'event.dart';
import 'state.dart';

class InvoiceBloc extends SMixinBloc<InvoiceEvent, InvoiceState> {
  final InvoiceUseCase _useCase;
  static InvoiceState _state = const InvoiceState();

  InvoiceBloc(this._useCase) : super(_state) {
    on<GetInvoicesEvent>(_getInvoices);
  }

  void _getInvoices(GetInvoicesEvent event, Emitter<InvoiceState> emit) async {
    emit(_state = _state.copyWith(invoiceState: const SBlocState.loading()));

    final result = await _useCase.getInvoices();
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(invoiceState: SBlocState.success(data: user));
        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(invoiceState: SBlocState.error(error));
        return _state;
      },
    ));
  }
}
