import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:rider/features/domain/use_cases/rider_usecase.dart';
import 'event.dart';
import 'state.dart';

class RiderBloc extends SMixinBloc<RiderEvent, RiderState> {
  final RiderUseCase _useCase;
  static RiderState _state = const RiderState();

  RiderBloc(this._useCase) : super(_state) {
    on<LoginEvent>(_login);
    on<PostSupportEvent>(_addSupportEvent);
    on<EndDeliveryEvent>(_endDelivery);
    on<RemoveDeliveryEvent>(_removeDelivery);
    on<GetVehicleTypesEvent>(_getVehicleTypes);
    on<GetProfileEvent>(_getProfileEvent);
    on<GetDeliveriesEvent>(_getDeliveries);
  }

  FutureOr<void> _addSupportEvent(PostSupportEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(supportState: const SBlocState.loading()));

    final result = await _useCase.addSupport(event.text);
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(supportState: SBlocState.success(data: user));
        BotToast.showText(text: 'تم الارسال بنجاح');

        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(supportState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  FutureOr<void> _login(LoginEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(loginState: const SBlocState.loading()));

    final result = await _useCase.login(
      deviceToken: event.deviceToken,
      rememberMe: event.rememberMe,
      email: event.email,
      password: event.password,
    );
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(loginState: SBlocState.success(data: user));
        // Navigator.pushNamedAndRemoveUntil(event.context, MapDriverScreen.idScreen, (route) => false);
        // displayToastMessage("انت مسجل دخول الان", event.context);
        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(loginState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  FutureOr<void> _endDelivery(EndDeliveryEvent event, Emitter<RiderState> emit) {}

  FutureOr<void> _removeDelivery(RemoveDeliveryEvent event, Emitter<RiderState> emit) {}

  FutureOr<void> _getVehicleTypes(GetVehicleTypesEvent event, Emitter<RiderState> emit) {}

  FutureOr<void> _getProfileEvent(GetProfileEvent event, Emitter<RiderState> emit) {}

  FutureOr<void> _getDeliveries(GetDeliveriesEvent event, Emitter<RiderState> emit) {}
}
