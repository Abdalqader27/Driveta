/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022

part of widgets;

class SKeyboardVisibilityBuilder extends StatefulWidget {
  final Widget? child;
  final Widget Function(
    BuildContext context,
    Widget? child,
    bool isKeyboardVisible,
  ) builder;

  const SKeyboardVisibilityBuilder({
    Key? key,
    this.child,
    required this.builder,
  }) : super(key: key);

  @override
  _SKeyboardVisibilityBuilderState createState() => _SKeyboardVisibilityBuilderState();
}

class _SKeyboardVisibilityBuilderState extends State<SKeyboardVisibilityBuilder> with WidgetsBindingObserver {
  var _isKeyboardVisible = WidgetsBinding.instance.window.viewInsets.bottom > 0.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeMetrics() {
    final bottomInset = WidgetsBinding.instance.window.viewInsets.bottom;
    final newValue = bottomInset > 0.0;
    if (newValue != _isKeyboardVisible) {
      setState(() => _isKeyboardVisible = newValue);
    }
  }

  @override
  Widget build(BuildContext context) => widget.builder(
        context,
        widget.child,
        _isKeyboardVisible,
      );
}
