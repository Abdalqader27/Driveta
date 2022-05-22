/// File Updated by
/// Abed <Abed-supy-io>
/// on 10 /May/2022
part of widgets;

class SFormItemField extends StatelessWidget {
  final String title;
  final String? hint;
  final String? validationMessage;
  final TextEditingController controller;
  final bool multiLines;
  final TextDirection? textDirection;
  final TextInputType? keyboardType;
  final bool onlyEnglish;
  final bool onlyArabic;
  final bool onlyDigit;
  final Color? borderColor;

  const SFormItemField({
    Key? key,
    required this.controller,
    required this.title,
    this.validationMessage,
    this.hint,
    this.keyboardType,
    this.multiLines = false,
    this.onlyEnglish = false,
    this.onlyArabic = false,
    this.onlyDigit = false,
    this.textDirection,
    this.borderColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SText.bodyLarge(title, style: Theme.of(context).textTheme.bodyText2!.copyWith(fontWeight: FontWeight.bold)),
        const SSizedBox.v4(),
        Card(
          elevation: 0,
          shape:
              RoundedRectangleBorder(borderRadius: SRadius.bRC6, side: BorderSide(color: borderColor ?? Colors.grey)),
          clipBehavior: Clip.antiAlias,
          child: TextFormField(
            controller: controller,
            autofocus: false,
            keyboardType: keyboardType ?? TextInputType.text,
            textDirection: textDirection,
            minLines: multiLines ? 4 : 1,
            maxLines: multiLines ? 6 : null,
            inputFormatters: [
              if (onlyArabic)
                FilteringTextInputFormatter.allow(RegExp("[\u0621-\u064a-\ ]", unicode: true))
              else if (onlyEnglish)
                FilteringTextInputFormatter.allow(RegExp(r'^(?:[a-zA-Z]|\P{L})+$', unicode: true))
              else if (onlyDigit)
                FilteringTextInputFormatter.digitsOnly
            ],
            decoration: InputDecoration(
                hintText: hint,
                hintTextDirection: textDirection,
                border: InputBorder.none,
                disabledBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
            validator: (String? value) {
              if (value!.isEmpty) {
                return validationMessage;
              }
              return null;
            },
          ),
        ),
        const SSizedBox.v4(),
      ],
    );
  }
}
