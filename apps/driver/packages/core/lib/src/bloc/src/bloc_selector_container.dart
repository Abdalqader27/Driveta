/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of '../s_bloc.dart';

/// T type
/// S state
/// B bloc
class BlocContainerSelector<T, B extends StateStreamable<S>, S> extends StatelessWidget {
  final ViewModelBuilder<T> builder;
  final Widget? initChild;
  final BlocWidgetSelector<S, SBlocState> selector;
  final Function()? onInit;
  final Function() onRetry;
  final Widget loadingWidget;
  final ErrorModelBuilder<dynamic> errorBuilder;

  const BlocContainerSelector(
      {Key? key,
      required this.builder,
      this.onInit,
      this.initChild,
      required this.selector,
      required this.onRetry,
      required this.loadingWidget,
      required this.errorBuilder})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocSelector<B, S, SBlocState>(
          selector: selector,
          builder: (context, SBlocState state) {
            return state.when(
              init: () {
                if (onInit != null) onInit!();
                return initChild ?? const SizedBox.shrink();
              },
              loading: () {
                return Center(child: loadingWidget);
              },
              success: (data) {
                return builder(context, data);
              },
              error: (error) {
                return errorBuilder(context, error, onRetry);
              },
            );
          }),
    );
  }
}
