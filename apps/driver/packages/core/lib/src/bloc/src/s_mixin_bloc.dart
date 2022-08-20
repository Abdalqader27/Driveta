/// File created by
/// Abed <Abed-supy-io>
/// on 14 /Apr/2022
part of '../s_bloc.dart';

const duration = Duration(milliseconds: 300);

EventTransformer<Event> debounce<Event>(Duration duration) {
  return (events, mapper) => events.debounce(duration).switchMap(mapper);
}

abstract class SMixinBloc<Event, State> extends Bloc<Event, State> {
  SMixinBloc(State initialState) : super(initialState);
  Event? _event;

  @override
  void onEvent(Event event) {
    _event = event;
    super.onEvent(event);
  }

  void retry() {
    if (_event != null) {
      add(_event!);
    }
  }
}
// abstract class SMixinIsolateBloc<Event, State> extends IsolateBloc<Event, State> {
//   SMixinIsolateBloc(State initialState) : super(initialState);
//   Event? _event;
//
//   @override
//   void onEvent(Event event) {
//     _event = event;
//     super.onEvent(event);
//   }
//
//   void retry() {
//     if (_event != null) {
//       add(_event!);
//     }
//   }
// }
