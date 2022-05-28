import 'package:freezed_annotation/freezed_annotation.dart';

part 's_bloc_state.freezed.dart';

@freezed
class SBlocState<S> with _$SBlocState<S> {
  const factory SBlocState.init() = BlocInitial;

  const factory SBlocState.loading() = BlocLoading;

  const factory SBlocState.success({required S? data}) = BlocSuccess<S>;

  const factory SBlocState.error(dynamic error) = BlocError;
}
