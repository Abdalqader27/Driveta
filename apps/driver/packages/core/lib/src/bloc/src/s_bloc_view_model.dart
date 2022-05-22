/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of '../s_bloc.dart';

typedef ViewModelBuilder<ViewModel> = Widget Function(
  BuildContext context,
  ViewModel vm,
);
typedef ErrorModelBuilder<ViewModel> = Widget Function(
  BuildContext context,
  ViewModel vm,
  Function() retry,
);

enum BlocDialog { loading, state1, state2 }
