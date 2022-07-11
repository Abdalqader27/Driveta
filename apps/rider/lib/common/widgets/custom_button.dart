import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    this.title,
    this.onPressed,
//    this.width = Sizes.WIDTH_150,
    this.height = 50,
    this.elevation = 1,
    this.borderRadiusTopLeft = 18,
    this.borderRadiusBottomRight = 18,
    this.borderRadiusBottomLeft = 0,
    this.borderRadiusTopRight = 0,
    this.color = Colors.purple,
    this.textStyle,
    this.icon,
    this.hasIcon = false,
  }) : super(key: key);

  final VoidCallback? onPressed;

//  final double width;
  final double height;
  final double elevation;
  final double borderRadiusTopLeft;
  final double borderRadiusTopRight;
  final double borderRadiusBottomLeft;
  final double borderRadiusBottomRight;
  final String? title;
  final Color color;
  final TextStyle? textStyle;
  final Widget? icon;
  final bool hasIcon;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      highlightColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onPressed: onPressed,
      elevation: elevation,
//      minWidth: width ?? MediaQuery.of(context).size.width,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadiusTopLeft),
          topRight: Radius.circular(borderRadiusTopRight),
          bottomLeft: Radius.circular(borderRadiusBottomLeft),
          bottomRight: Radius.circular(borderRadiusBottomRight),
        ),
      ),

      height: height,
      color: color,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          hasIcon ? icon! : Container(),
          hasIcon
              ? SizedBox(
                  width: 8,
                )
              : Container(),
          title != null
              ? Text(
                  title!,
                  style: textStyle?.copyWith(color: Colors.white, fontSize: 16),
                )
              : Container(),
        ],
      ),
    );
  }
}
