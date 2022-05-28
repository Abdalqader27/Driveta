/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of '../s_bloc.dart';

class SBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    ///TODO should replace it with logging
    log('Create ---> ' + bloc.runtimeType.toString());
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase bloc) {
    log('Close ---> ' + bloc.runtimeType.toString());
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    log('Error  occurred in ${bloc.runtimeType}\n'
        '-----------------StackTrace--------------------\n'
        '${stackTrace.toString()}');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    log('-----------------Bloc Transition------------------------\n'
        'bloc: ${bloc.runtimeType}\n'
        'Event: ${transition.event.runtimeType}\n'
        'CurrentState: ${transition.currentState.runtimeType}\n'
        'NextState: ${transition.nextState.runtimeType}\n'
        '----------------------------------------------------------\n');

    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    log('--------------------------Bloc Event-----------------------\n'
        'bloc: ${bloc.runtimeType}\n'
        'event: ${event.runtimeType}\n'
        '-------------------------------------------------------------\n');
    super.onEvent(bloc, event);
  }
}
