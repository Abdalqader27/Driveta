/// File created by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of widgets;

class SVisibility extends StatelessWidget {
  const SVisibility({
    Key? key,
    required this.condition,
    required this.child,
    this.replacements = const [],
  }) : super(key: key);
  final bool condition;
  final Widget child;
  final List<SVisibility?> replacements;

  @override
  Widget build(BuildContext context) {
    if (condition) {
      /// if you condition is true lets return the item
      return child;
    } else {
      /// if not lets return the first item is not null and its
      /// condition is true
      if (replacements.isNotEmpty) {
        /// loop your replacements list to set the
        for (var widget in replacements) {
          /// first one has true condition and is not null
          if (widget != null && widget.condition) {
            return widget;
          }
        }
      }

      /// for default with empty replacements list
      /// the  return is
      return const SizedBox.shrink();
    }
  }
}

/// =>Example
///    SVisibility(
///      condition: false,
///      child: Container(
///      height: 10,
///      color: Colors.blue ),
///      replacements: [
///          null,
///          SVisibility(
///          condition: false,
///          child: Container(
///          height: 10,
///          color: Colors.red),
///           ),
///          SVisibility(
///          condition: true,
///          child: Container(
///          height: 10,
///          color: Colors.orange),
///           ),
///          SVisibility(
///          condition: true,
///          child: Container(
///          height: 10,
///          color: Colors.gray),
///           ),

///                         ],
///    ),
