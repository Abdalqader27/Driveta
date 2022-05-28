import 'package:core/core.dart';import 'package:design/design.dart';import 'package:easy_localization/easy_localization.dart';import '../../generated/assets.dart';class BlocSelectorWrapper<T, B extends StateStreamable<S>, S> extends StatelessWidget {  final ViewModelBuilder<T> builder;  final BlocWidgetSelector<S, SBlocState> selector;  final Function() onRetry;  final Widget? initChild;  final Widget? loading;  final Function()? onInit;  /// TODO need to rename the props here  const BlocSelectorWrapper({    Key? key,    required this.builder,    required this.selector,    required this.onRetry,    this.onInit,    this.initChild,    this.loading,  }) : super(key: key);  @override  Widget build(BuildContext context) {    return BlocContainerSelector<T, B, S>(      onRetry: onRetry,      onInit: onInit,      selector: selector,      initChild: initChild,      builder: builder,      errorBuilder: (_, error, retry) {        if (error.error.toString().contains('No Internet'.tr())) {          return SNoInternetScreen(            error: error.error,            message: error.message,            retryText: 'Retry'.tr(),            retry: retry,          );        }        return SErrorScreen(          retry: retry,          message: error.message,          error: error.error,          retryText: 'Retry'.tr(),          svgPath: Assets.iconsGroup7,        );      },      loadingWidget: loading ?? const SLoading(),    );  }}