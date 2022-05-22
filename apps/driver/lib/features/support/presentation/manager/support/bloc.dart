import 'package:bot_toast/bot_toast.dart';
import 'package:core/core.dart';

import '../../../domain/use_cases/support_usecase.dart';
import 'event.dart';
import 'state.dart';

class SupportBloc extends SMixinBloc<SupportEvent, SupportState> {
  final SupportUseCase _useCase;
  static SupportState _state = const SupportState();

  SupportBloc(this._useCase) : super(_state) {
    on<PostSupportEvent>(_addSupportEvent);
  }

  void _addSupportEvent(PostSupportEvent event, Emitter<SupportState> emit) async {
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
}
