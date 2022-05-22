import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class SupportState extends Equatable {
  final SBlocState? supportState;

  const SupportState({
    this.supportState = const SBlocState.init(),
  });

  SupportState copyWith({
    SBlocState? supportState,
  }) {
    return SupportState(
      supportState: supportState ?? this.supportState,
    );
  }

  @override
  List<Object?> get props => [
        supportState,
      ];
}
