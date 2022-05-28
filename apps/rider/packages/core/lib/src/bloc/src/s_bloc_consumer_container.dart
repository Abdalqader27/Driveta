/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of '../s_bloc.dart';

class SBlocConsumer<T, B extends StateStreamable<SBlocState>> extends StatelessWidget {
  final ViewModelBuilder<T?> builder;
  final Widget loadingWidget;
  final ErrorModelBuilder<dynamic> errorBuilder;
  final Function() onInit;
  final Function() retry;

  /// TODO add listener
  const SBlocConsumer({
    Key? key,
    required this.builder,
    required this.onInit,
    required this.retry,
    required this.loadingWidget,
    required this.errorBuilder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: BlocConsumer<B, SBlocState>(
          listener: _listener,
          buildWhen: buildWhen,
          builder: (context, SBlocState state) {
            return state.when(
              init: () {
                onInit();
                return const SizedBox.shrink();
              },
              loading: () {
                return loadingWidget;
              },
              success: (data) {
                return builder(context, data);
              },
              error: (error) {
                return errorBuilder(context, error, retry);
              },
            );
          }),
    );
  }

  _listener(BuildContext context, SBlocState state) {}

  bool buildWhen(SBlocState pre, SBlocState next) {
    if ((pre != next)) return true;
    return false;
  }
}
