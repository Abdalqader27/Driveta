import 'package:core/core.dart';
import 'package:design/design.dart';

import '../../../../map_driver/presentation/pages/map_driver/map_driver.dart';
import '../../../domain/use_cases/profile_usecase.dart';
import 'event.dart';
import 'state.dart';

class ProfileBloc extends SMixinBloc<ProfileEvent, ProfileState> {
  final ProfileUseCase _useCase;
  static ProfileState _state = const ProfileState();

  ProfileBloc(this._useCase) : super(_state) {
    on<GetProfileEvent>(_getProfile);
  }

  void _getProfile(GetProfileEvent event, Emitter<ProfileState> emit) async {
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
}
