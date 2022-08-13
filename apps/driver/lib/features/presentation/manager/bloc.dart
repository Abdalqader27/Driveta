import 'dart:async';

import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';
import 'package:design/design.dart';
import 'package:driver/features/domain/use_cases/driver_usecase.dart';
import 'package:driver/features/presentation/pages/sgin_in/login_screen.dart';
import 'package:driver/features/presentation/pages/sgin_up/registeration_screen.dart';

import '../pages/map_driver/available_deliver.dart';
import '../pages/map_driver/map_driver.dart';
import 'event.dart';
import 'state.dart';

class DriverBloc extends SMixinBloc<DriverEvent, DriverState> {
  final DriverUseCase _useCase;
  static DriverState _state = const DriverState();

  DriverBloc(this._useCase) : super(_state) {
    on<PostSupportEvent>(_addSupportEvent);
    on<GetProfileEvent>(_getProfile);
    on<GetInvoicesEvent>(_getInvoices);
    on<GetStatisticsEvent>(_getStatistics);
    on<GetHistoriesEvent>(_getHistory);
    on<GetAvailableDeliveries>(_getAvailableDeliveries);
    on<LoginEvent>(_login);
    on<SignUPEvent>(_signUp);
  }

  FutureOr<void> _addSupportEvent(
      PostSupportEvent event, Emitter<DriverState> emit) async {
    emit(_state = _state.copyWith(supportState: const BlocLoading()));

    final result = await _useCase.addSupport(event.text);
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(supportState: BlocSuccess(data: user));
        BotToast.showText(text: 'تم الارسال بنجاح');
        return _state;
      },
      failure: (error) {
        BotToast.showText(text: 'error');
        _state = _state.copyWith(supportState: BlocInitial());
        return _state;
      },
    ));
  }

  void _getProfile(GetProfileEvent event, Emitter<DriverState> emit) async {
    emit(_state = _state.copyWith(infoState: const SBlocState.loading()));

    final result = await _useCase.getProfile();
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(infoState: SBlocState.success(data: user));
        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(infoState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  void _getInvoices(GetInvoicesEvent event, Emitter<DriverState> emit) async {
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

  void _getStatistics(
      GetStatisticsEvent event, Emitter<DriverState> emit) async {
    emit(_state = _state.copyWith(statisticsSate: const SBlocState.loading()));

    final result = await _useCase.getStatistics();
    emit(await result.when(
      success: (data) {
        _state =
            _state.copyWith(statisticsSate: SBlocState.success(data: data));
        return _state;
      },
      failure: (error) {
        _state = _state.copyWith(statisticsSate: SBlocState.error(error));
        return _state;
      },
    ));
  }

  void _getHistory(GetHistoriesEvent event, Emitter<DriverState> emit) async {
    emit(_state = _state.copyWith(historyState: const SBlocState.loading()));

    final result = await _useCase.getHistories();
    emit(await result.when(
      success: (data) {
        _state = _state.copyWith(historyState: SBlocState.success(data: data));

        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(historyState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  void _getAvailableDeliveries(
      GetAvailableDeliveries event, Emitter<DriverState> emit) async {
    final result = await _useCase.getAvailableDelivers();

    emit(await result.when(
      success: (data) {
        _state = _state.copyWith(
            getAvailableDeliveriesState: SBlocState.success(data: data));
        deliversStream.sink.add(data);
        return _state;
      },
      failure: (dynamic error) {
        _state = _state.copyWith(
            getAvailableDeliveriesState: SBlocState.error(error));
        return _state;
      },
    ));
  }

  void _login(LoginEvent event, Emitter<DriverState> emit) async {
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
        Navigator.pushNamedAndRemoveUntil(
            event.context, MapDriverScreen.idScreen, (route) => false);
        displayToastMessage("انت مسجل دخول الان", event.context);
        return _state;
      },
      failure: (error) {
        BotToast.showText(text: '$error');
        _state = _state.copyWith(loginState: const SBlocState.init());
        return _state;
      },
    ));
  }

  FutureOr<void> _signUp(SignUPEvent event, Emitter<DriverState> emit) async {
    emit(_state = _state.copyWith(signUpState: const BlocLoading()));
    final result = await _useCase.signUp(
      userName: event.userName,
      name: event.name,
      phoneNumber: event.phoneNumber,
      sexType: event.sexType,
      bloodType: event.bloodType,
      dob: event.dob,
      personalImageFile: event.personalImageFile,
      idPhotoFile: event.idPhotoFile,
      drivingCertificateFile: event.drivingCertificateFile,
      email: event.email,
      password: event.password,
    );
    emit(await result.when(
      success: (user) {
        _state = _state.copyWith(signUpState: BlocSuccess(data: user));
        Navigator.pushNamedAndRemoveUntil(
            event.context, LoginScreen.idScreen, (route) => false);
        displayToastMessage(
            "سوف يتم ارسال رسالة الى هاتفك توكد عملية التفعيل الحساب",
            event.context);
        return _state;
      },
      failure: (dynamic error) {
        BotToast.showText(text: '$error');
        _state = _state.copyWith(signUpState: const SBlocState.init());
        return _state;
      },
    ));
  }
}
