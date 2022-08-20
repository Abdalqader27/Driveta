/// File Created by
/// Abed <Joelle-supy-io>
/// on 6 /Feb/2022
///--------------------------
/// File Updated by
/// Abed <Abed-supy-io>
/// on 27 /Apr/2022
part of widgets;

class SAppBar extends StatelessWidget implements PreferredSizeWidget {
  const SAppBar({Key? key, required this.title, this.leading, this.actions}) : super(key: key);
  final String title;
  final Widget? leading;
  final List<Widget>? actions;
  @override
  Widget build(BuildContext context) {
    return AppBar(
        leading: leading,
        centerTitle: true,
        elevation: 0.5,
        title: SText.headlineMedium(title,
            style: Theme.of(context).textTheme.headline6!.copyWith(fontSize: 18, fontWeight: FontWeight.w700)),
        actions: actions);
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
