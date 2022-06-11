import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class RiderState extends Equatable {
  final SBlocState? loginState;
  final SBlocState? signUpState;
  final SBlocState? supportState;
  final SBlocState? endDeliveryState;
  final SBlocState? removeDeliveryState;
  final SBlocState? getVehicleTypesState;
  final SBlocState? getProfileState;
  final SBlocState? getDeliveriesState;

  const RiderState({
    this.loginState = const SBlocState.init(),
    this.signUpState = const SBlocState.init(),
    this.supportState = const SBlocState.init(),
    this.endDeliveryState = const SBlocState.init(),
    this.removeDeliveryState = const SBlocState.init(),
    this.getVehicleTypesState = const SBlocState.init(),
    this.getProfileState = const SBlocState.init(),
    this.getDeliveriesState = const SBlocState.init(),
  });

  RiderState copyWith({
    SBlocState? loginState,
    SBlocState? signUpState,
    SBlocState? supportState,
    SBlocState? endDeliveryState,
    SBlocState? removeDeliveryState,
    SBlocState? getVehicleTypesState,
    SBlocState? getProfileState,
    SBlocState? getDeliveriesState,
  }) {
    return RiderState(
      loginState: loginState ?? this.loginState,
      signUpState: signUpState ?? this.signUpState,
      supportState: supportState ?? this.supportState,
      endDeliveryState: endDeliveryState ?? this.endDeliveryState,
      removeDeliveryState: removeDeliveryState ?? this.removeDeliveryState,
      getVehicleTypesState: getVehicleTypesState ?? this.getVehicleTypesState,
      getProfileState: getProfileState ?? this.getProfileState,
      getDeliveriesState: getDeliveriesState ?? this.getDeliveriesState,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        signUpState,
        supportState,
        endDeliveryState,
        removeDeliveryState,
        getVehicleTypesState,
        getProfileState,
        getDeliveriesState,
      ];
}