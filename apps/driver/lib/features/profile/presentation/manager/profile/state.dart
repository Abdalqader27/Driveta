import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

class ProfileState extends Equatable {
  final SBlocState? infoState;

  const ProfileState({
    this.infoState = const SBlocState.init(),
  });

  ProfileState copyWith({
    SBlocState? infoState,
  }) {
    return ProfileState(
      infoState: infoState ?? this.infoState,
    );
  }

  @override
  List<Object?> get props => [
        infoState,
      ];
}
