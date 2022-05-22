import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class HistoryState extends Equatable {
  final SBlocState? historyState;

  const HistoryState({
    this.historyState = const SBlocState.init(),
  });

  HistoryState copyWith({
    SBlocState? historyState,
  }) {
    return HistoryState(
      historyState: historyState ?? this.historyState,
    );
  }

  @override
  List<Object?> get props => [
        historyState,
      ];
}
