import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:moor/moor.dart';
import 'package:rider/features/domain/use_cases/rider_usecase.dart';
import 'package:rider/main.dart';

import '../../data/database/app_db.dart';
import '../pages/map/main_screen/mainscreen.dart';
import '../pages/sgin_up/registeration_screen.dart';
import 'event.dart';
import 'state.dart';

class RiderBloc extends SMixinBloc<RiderEvent, RiderState> {
  final RiderUseCase _useCase;
  static RiderState _state = const RiderState();

  RiderBloc(this._useCase) : super(_state) {
    on<LoginEvent>(_login);
    on<PostSupportEvent>(_addSupportEvent);
    on<RemoveDeliveryEvent>(_removeDelivery);
    on<GetVehicleTypesEvent>(_getVehicleTypes);
    on<GetProfileEvent>(_getProfileEvent);
    on<GetDeliveriesEvent>(_getDeliveries);
    on<GetDeliveriesProductEvent>(_getDeliveriesProduct);
    on<GetStoreDetailsEvent>(_getStoreDetails);
    on<GetStoresEvent>(_getStores);
  }

  FutureOr<void> _addSupportEvent(
      PostSupportEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(supportState: const BlocLoading()));
    final result = await _useCase.addSupport(event.text);
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(supportState: BlocSuccess(data: user));
        BotToast.showText(text: 'تم الارسال بنجاح');
        return _state;
      },
      failure: (error) {
        return _state = _state.copyWith(supportState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _login(LoginEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(loginState: const BlocLoading()));
    final result = await _useCase.login(
      deviceToken: event.deviceToken,
      rememberMe: event.rememberMe,
      email: event.email,
      password: event.password,
    );
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(loginState: BlocSuccess(data: user));
        Navigator.pushNamedAndRemoveUntil(
            event.context, MainScreen.idScreen, (route) => false);
        displayToastMessage("انت مسجل دخول الان", event.context);
        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(loginState: BlocError(error));
        return _state;
      },
    ));
  }

  FutureOr<void> _removeDelivery(
      RemoveDeliveryEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(removeDeliveryState: const BlocLoading()));
    final result = await _useCase.removeDelivery();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(removeDeliveryState: BlocSuccess(data: data));
      },
      failure: (dynamic error) {
        return _state = _state.copyWith(removeDeliveryState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getVehicleTypes(
      GetVehicleTypesEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(getVehicleTypesState: const BlocLoading()));
    final result = await _useCase.getVehicleTypes();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(getVehicleTypesState: BlocSuccess(data: data));
      },
      failure: (error) {
        return _state = _state.copyWith(getVehicleTypesState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getProfileEvent(
      GetProfileEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(getProfileState: const BlocLoading()));
    final result = await _useCase.profile();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(getProfileState: BlocSuccess(data: data));
      },
      failure: (dynamic error) {
        return _state = _state.copyWith(getProfileState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getDeliveries(
      GetDeliveriesEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(getDeliveriesState: const BlocLoading()));
    final result = await _useCase.getDeliveries();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(getDeliveriesState: BlocSuccess(data: data));
      },
      failure: (error) {
        return _state = _state.copyWith(getDeliveriesState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getDeliveriesProduct(
      GetDeliveriesProductEvent event, Emitter<RiderState> emit) async {
    emit(_state =
        _state.copyWith(getDeliveriesProductState: const BlocLoading()));
    final result = await _useCase.getProductDeliveries();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(getDeliveriesProductState: BlocSuccess(data: data));
      },
      failure: (error) {
        return _state =
            _state.copyWith(getDeliveriesProductState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getStoreDetails(
      GetStoreDetailsEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(getStoreDetailsState: const BlocLoading()));
    final result = await _useCase.getStoreDetails(event.id);
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        return _state =
            _state.copyWith(getStoreDetailsState: BlocSuccess(data: data));
      },
      failure: (error) {
        return _state = _state.copyWith(getStoreDetailsState: BlocError(error));
      },
    ));
  }

  FutureOr<void> _getStores(
      GetStoresEvent event, Emitter<RiderState> emit) async {
    emit(_state = _state.copyWith(getStoresState: const BlocLoading()));
    final result = await _useCase.getStores();
    emit(await result.when(
      success: (data) {
        BotToast.showText(text: 'تم  بنجاح');
        List<ShopsCompanion> shopsList = [];
        for (var d in data) {
          shopsList.add(ShopsCompanion(
            id: Value(d.id ?? ''),
            name: Value(d.name ?? ''),
            description: Value(d.description ?? ''),
            userName: Value(d.userName ?? ''),
            email: Value(d.email ?? ''),
            lat: Value(d.lat ?? ''),
            long: Value(d.long ?? ''),
            personalImage: Value(d.personalImage ?? ''),
            storeOwnerName: Value(d.storeOwnerName ?? ''),
            streetId: Value(d.streetId ?? ''),
          ));
        }
        appDatabase.shopsDAO.insertAll(shopsList);
        return _state =
            _state.copyWith(getStoresState: BlocSuccess(data: data));
      },
      failure: (error) {
        return _state = _state.copyWith(getStoresState: BlocError(error));
      },
    ));
  }
}
