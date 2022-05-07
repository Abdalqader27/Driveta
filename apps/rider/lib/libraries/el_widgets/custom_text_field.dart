import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final IconData? prefix;
  final TextInputType? keyboardType;
  final FocusNode? focus;
  final TextInputAction? textInputAction;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)? onChange;
  final Function()? onTap;
  final Color? iconColor;
  final TextEditingController? controller;
  final int? maxLines;
  final bool enabled;
  final bool readOnly;
  final bool? obscureText;
  final TextStyle? textFieldStyle;
  final VoidCallback? onEditingComplete;

  const CustomTextField({
    Key? key,
    required this.hintText,
    this.prefix,
    this.maxLines,
    this.onEditingComplete,
    this.keyboardType,
    this.focus,
    this.controller,
    this.validator,
    this.onChange,
    this.initialValue,
    this.textInputAction,
    this.iconColor,
    this.onTap,
    this.enabled = true,
    this.readOnly = false,
    this.textFieldStyle,
    this.obscureText,
  }) : super(key: key);

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool? _obscureText;

  @override
  void initState() {
    _obscureText = widget.obscureText;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final themeData = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: TextFormField(
        obscureText: _obscureText ?? false,
        focusNode: widget.focus,
        enabled: widget.enabled,
        textAlign: TextAlign.right,
        initialValue: widget.initialValue,
        validator: widget.validator,
        controller: widget.controller,
        maxLines: widget.maxLines,
        textDirection: TextDirection.rtl,
        onChanged: widget.onChange,
        onTap: widget.onTap,
        readOnly: widget.readOnly,
        style: widget.textFieldStyle,
        textInputAction: widget.textInputAction ?? TextInputAction.next,
        keyboardType: widget.keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
            fillColor: themeData.inputDecorationTheme.fillColor,
            filled: themeData.inputDecorationTheme.filled,
            labelStyle: themeData.inputDecorationTheme.labelStyle,
            hintStyle: themeData.inputDecorationTheme.hintStyle,
            border: themeData.inputDecorationTheme.border,
            errorStyle: themeData.inputDecorationTheme.errorStyle,
            contentPadding:
                themeData.inputDecorationTheme.contentPadding ?? EdgeInsets.symmetric(horizontal: 16.h, vertical: 16.h),
            label: Text(widget.hintText),
            suffixIcon: _obscureText != null
                ? IconButton(
                    onPressed: _onTapEye,
                    icon: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 250),
                      transitionBuilder: (child, animation) => FadeTransition(
                        opacity: animation,
                        child: SizeTransition(
                          sizeFactor: animation,
                          child: child,
                        ),
                      ),
                      child: Icon(
                        _obscureText! ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                        key: Key(
                          _obscureText.toString(),
                        ),
                      ),
                    ),
                  )
                : null,
            prefixIcon: widget.prefix != null
                ? Icon(
                    widget.prefix,
                    size: themeData.iconTheme.size,
                    color: widget.iconColor,
                  )
                : null,
            prefixIconConstraints: BoxConstraints(minWidth: 40.w)),
      ),
    );
  }

  void _onTapEye() => setState(() => _obscureText = !_obscureText!);
}
