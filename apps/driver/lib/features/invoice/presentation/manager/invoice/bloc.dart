import 'package:core/core.dart';

import '../../../domain/use_cases/invoice_usecase.dart';
import 'event.dart';
import 'state.dart';

class InvoiceBloc extends SMixinBloc<InvoiceEvent, InvoiceState> {
  final InvoiceUseCase _useCase;
  static InvoiceState _state = const InvoiceState();

  InvoiceBloc(this._useCase) : super(_state) {
    on<GetInvoicesEvent>(_getInvoices);
    on<GetStatisticsEvent>(_getStatistics);
  }

  void _getInvoices(GetInvoicesEvent event, Emitter<InvoiceState> emit) async {
    emit(_state = _state.copyWith(invoiceState: const SBlocState.loading()));

    final result = await _useCase.getInvoices();
    emit(await result.when(
      success: (data) {
        _state = _state.copyWith(invoiceState: SBlocState.success(data: data));
        return _state;
      },
      failure: (error) {
        _state = _state.copyWith(invoiceState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  void _getStatistics(GetStatisticsEvent event, Emitter<InvoiceState> emit) async {
    emit(_state = _state.copyWith(statisticsSate: const SBlocState.loading()));

    final result = await _useCase.getStatistics();
    emit(await result.when(
      success: (data) {
        _state = _state.copyWith(statisticsSate: SBlocState.success(data: data));
        return _state;
      },
      failure: (error) {
        _state = _state.copyWith(statisticsSate: SBlocState.error(error));
        return _state;
      },
    ));
  }
}
