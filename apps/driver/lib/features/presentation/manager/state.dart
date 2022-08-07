import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class DriverState extends Equatable {
  final SBlocState? infoState;
  final SBlocState? invoiceState;
  final SBlocState? statisticsSate;
  final SBlocState? getAvailableDeliveriesState;
  final SBlocState? supportState;
  final SBlocState? historyState;
  final SBlocState? loginState;
  final SBlocState? signUpState;

  const DriverState({
    this.supportState = const BlocInitial(),
    this.getAvailableDeliveriesState = const BlocInitial(),
    this.infoState = const BlocInitial(),
    this.statisticsSate = const BlocInitial(),
    this.invoiceState = const BlocInitial(),
    this.historyState = const BlocInitial(),
    this.loginState = const BlocInitial(),
    this.signUpState = const BlocInitial(),
  });

  DriverState copyWith({
    SBlocState? supportState,
    SBlocState? getAvailableDeliveriesState,
    SBlocState? infoState,
    SBlocState? invoiceState,
    SBlocState? statisticsSate,
    SBlocState? historyState,
    SBlocState? signUpState,
    SBlocState? loginState,
  }) {
    return DriverState(
      supportState: supportState ?? this.supportState,
      getAvailableDeliveriesState:
          getAvailableDeliveriesState ?? this.getAvailableDeliveriesState,
      infoState: infoState ?? this.infoState,
      invoiceState: invoiceState ?? this.invoiceState,
      statisticsSate: statisticsSate ?? this.statisticsSate,
      historyState: historyState ?? this.historyState,
      loginState: loginState ?? this.loginState,
      signUpState: signUpState ?? this.signUpState,
    );
  }

  @override
  List<Object?> get props => [
        supportState,
        getAvailableDeliveriesState,
        infoState,
        invoiceState,
        statisticsSate,
        historyState,
        signUpState,
        loginState,
      ];
}
