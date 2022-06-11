import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class DriverState extends Equatable {
  final SBlocState? infoState;
  final SBlocState? invoiceState;
  final SBlocState? statisticsSate;
  final SBlocState? supportState;
  final SBlocState? historyState;
  final SBlocState? loginState;
  final SBlocState? signState;
  const DriverState({
    this.supportState = const BlocInitial(),
    this.infoState = const BlocInitial(),
    this.statisticsSate = const BlocInitial(),
    this.invoiceState = const BlocInitial(),
    this.historyState = const BlocInitial(),
    this.loginState = const BlocInitial(),
    this.signState = const BlocInitial(),
  });

  DriverState copyWith({
    SBlocState? supportState,
    SBlocState? infoState,
    SBlocState? invoiceState,
    SBlocState? statisticsSate,
    SBlocState? historyState,
    SBlocState? signState,
    SBlocState? loginState,
  }) {
    return DriverState(
      supportState: supportState ?? this.supportState,
      infoState: infoState ?? this.infoState,
      invoiceState: invoiceState ?? this.invoiceState,
      statisticsSate: statisticsSate ?? this.statisticsSate,
      historyState: historyState ?? this.historyState,
      loginState: loginState ?? this.loginState,
      signState: signState ?? this.signState,
    );
  }

  @override
  List<Object?> get props => [
        supportState,
        infoState,
        invoiceState,
        statisticsSate,
        historyState,
        signState,
        loginState,
      ];
}
