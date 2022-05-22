import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:driver/Models/history.dart';

import '../../../domain/use_cases/history_usecase.dart';
import 'event.dart';
import 'state.dart';

class HistoryBloc extends SMixinBloc<HistoryEvent, HistoryState> {
  final HistoryUseCase _useCase;
  static HistoryState _state = const HistoryState();

  HistoryBloc(this._useCase) : super(_state) {
    on<GetHistoriesEvent>(_getHistory);
  }

  void _getHistory(GetHistoriesEvent event, Emitter<HistoryState> emit) async {
    emit(_state = _state.copyWith(historyState: const SBlocState.loading()));

    final result = await _useCase.getHistories();
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(historyState: SBlocState.success(data: user));

        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(historyState: SBlocState.error(error));
        return _state;
      },
    ));
  }
}
