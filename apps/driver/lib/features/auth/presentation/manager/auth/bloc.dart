import 'package:core/core.dart';
import 'package:design/design.dart';

import '../../../../map_driver/presentation/pages/map_driver/map_driver.dart';
import '../../../domain/use_cases/auth_usecase.dart';
import '../../pages/sgin_up/registeration_screen.dart';
import 'event.dart';
import 'state.dart';

class AuthBloc extends SMixinBloc<AuthEvent, AuthState> {
  final AuthUseCase _useCase;
  static AuthState _authState = const AuthState();

  AuthBloc(this._useCase) : super(_authState) {
    on<LoginEvent>(_login);
  }

  void _login(LoginEvent event, Emitter<AuthState> emit) async {
    emit(_authState = _authState.copyWith(loginState: const SBlocState.loading()));

    final result = await _useCase.login(
      deviceToken: event.deviceToken,
      rememberMe: event.rememberMe,
      email: event.email,
      password: event.password,
    );
    emit(await result.when(
      success: (user) {
        _authState = _authState.copyWith(loginState: SBlocState.success(data: user));
        Navigator.pushNamedAndRemoveUntil(event.context, MapDriverScreen.idScreen, (route) => false);
        displayToastMessage("انت مسجل دخول الان", event.context);
        return _authState;
      },
      failure: (dynamic error) {
        _authState = _authState.copyWith(loginState: SBlocState.error(error));
        return _authState;
      },
    ));
  }
}
