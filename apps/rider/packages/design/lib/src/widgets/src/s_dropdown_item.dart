/// File Updated by
/// Abed <Abed-supy-io>
/// on 2 /May/2022
part of widgets;

class SDropDownItem extends StatefulWidget {
  final List<String> items;
  final String title;
  final String? hint;
  final Color? borderColor;
  final String validationMessage;
  final TextEditingController controller;
  final ValueChanged<String> onChange;

  const SDropDownItem({
    Key? key,
    required this.controller,
    required this.title,
    required this.validationMessage,
    this.hint,
    this.borderColor,
    required this.items,
    required this.onChange,
  }) : super(key: key);

  @override
  State<SDropDownItem> createState() => _DropDownItemState();
}

class _DropDownItemState extends State<SDropDownItem> {
  String? selectedValue;

  @override
  void initState() {
    super.initState();
    if (widget.items.contains(widget.controller.text)) {
      selectedValue = widget.controller.text;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SText.titleMedium(widget.title,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
        const SSizedBox.v4(),
        Card(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
            side: BorderSide(color: widget.borderColor ?? Colors.grey),
          ),
          semanticContainer: true,
          child: DropdownButtonFormField<String>(
            decoration: const InputDecoration(
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
            value: selectedValue,
            hint: SPadding.h5(
              child: SText.titleMedium(
                "${widget.hint}",
              ),
            ),
            icon: const Icon(
              Icons.arrow_drop_down,
              color: Colors.black45,
            ),
            iconSize: 30,
            items: widget.items
                .map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: SText.titleMedium(item),
                    ))
                .toList(),
            validator: (value) {
              if (value == null) {
                return widget.validationMessage;
              }
              return null;
            },
            onChanged: (value) {
              widget.onChange(value.toString());
            },
            onSaved: (value) {
              widget.onChange(value.toString());
            },
          ),
        ),
        const SSizedBox.v4(),
      ],
    );
  }
}
