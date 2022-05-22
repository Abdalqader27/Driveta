import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  final SBlocState? loginState;
  final SBlocState? signState;

  const AuthState({
    this.loginState = const SBlocState.init(),
    this.signState = const SBlocState.init(),
  });

  AuthState copyWith({
    SBlocState? loginState,
    SBlocState? signState,
  }) {
    return AuthState(
      loginState: loginState ?? this.loginState,
      signState: signState ?? this.signState,
    );
  }

  @override
  List<Object?> get props => [
        loginState,
        signState,
      ];
}
