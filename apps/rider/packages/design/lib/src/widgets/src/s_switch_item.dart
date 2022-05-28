/// File created by
/// Abed <Abed-supy-io>
/// on 28 /Apr/2022
part of widgets;

class SSwitchItem extends StatelessWidget {
  final String text;
  final bool value;
  final ValueChanged<bool>? onChanged;

  const SSwitchItem({
    Key? key,
    required this.text,
    required this.value,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListTile(
          title: SText.titleMedium(text),
          trailing: Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: Theme.of(context).primaryColor,
          ),
        ),
        const SSizedBox.v2(),
      ],
    );
  }
}
