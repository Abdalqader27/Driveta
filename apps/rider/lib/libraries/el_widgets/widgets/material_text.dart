import 'dart:ui' as ui show TextHeightBehavior;

import 'package:flutter/material.dart';

class MaterialText extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final TextAlign? textAlign;
  final bool? softWrap;
  final TextOverflow? textOverflow;
  final int? maxLines;
  final Locale? locale;
  final String? semanticsLabel;
  final StrutStyle? strutStyle;
  final TextDirection? textDirection;
  final ui.TextHeightBehavior? textHeightBehavior;
  final double? textScaleFactor;
  final TextWidthBasis? textWidthBasis;

  const MaterialText(this.text,
      {Key? key,
      this.style,
      this.textAlign,
      this.softWrap,
      this.textOverflow,
      this.maxLines,
      this.locale,
      this.semanticsLabel,
      this.strutStyle,
      this.textDirection,
      this.textHeightBehavior,
      this.textScaleFactor,
      this.textWidthBasis})
      : super(key: key);

  const factory MaterialText.headLine1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine1;

  const factory MaterialText.headLine2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine2;

  const factory MaterialText.headLine3(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine3;

  const factory MaterialText.headLine4(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine4;

  const factory MaterialText.headLine5(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine5;

  const factory MaterialText.headLine6(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _HeadLine6;

  const factory MaterialText.bodyText1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _BodyText1;

  const factory MaterialText.bodyText2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _BodyText2;

  const factory MaterialText.subTitle1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _Subtitle1;

  const factory MaterialText.subTitle2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _Subtitle2;

  const factory MaterialText.button(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _Button;

  const factory MaterialText.caption(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _Caption;

  const factory MaterialText.overLine(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis}) = _OverLine;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: style,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine1 extends MaterialText {
  const _HeadLine1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline1 = Theme.of(context).textTheme.headline1;
    return Text(
      text,
      style: style != null ? headline1?.merge(style) : headline1,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine2 extends MaterialText {
  const _HeadLine2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline2 = Theme.of(context).textTheme.headline2;
    return Text(
      text,
      style: style != null ? headline2?.merge(style) : headline2,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine3 extends MaterialText {
  const _HeadLine3(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline3 = Theme.of(context).textTheme.headline3;
    return Text(
      text,
      style: style != null ? headline3?.merge(style) : headline3,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine4 extends MaterialText {
  const _HeadLine4(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline4 = Theme.of(context).textTheme.headline4;
    return Text(
      text,
      style: style != null ? headline4?.merge(style) : headline4,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine5 extends MaterialText {
  const _HeadLine5(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline5 = Theme.of(context).textTheme.headline5;
    return Text(
      text,
      style: style != null ? headline5?.merge(style) : headline5,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _HeadLine6 extends MaterialText {
  const _HeadLine6(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final headline6 = Theme.of(context).textTheme.headline6;
    return Text(
      text,
      style: style != null ? headline6?.merge(style) : headline6,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _BodyText1 extends MaterialText {
  const _BodyText1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final bodyText1 = Theme.of(context).textTheme.bodyText1;
    return Text(
      text,
      style: style != null ? bodyText1?.merge(style) : bodyText1,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _BodyText2 extends MaterialText {
  const _BodyText2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final bodyText2 = Theme.of(context).textTheme.bodyText2;
    return Text(
      text,
      style: style != null ? bodyText2?.merge(style) : bodyText2,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _Subtitle1 extends MaterialText {
  const _Subtitle1(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final subtitle1 = Theme.of(context).textTheme.subtitle1;
    return Text(
      text,
      style: style != null ? subtitle1?.merge(style) : subtitle1,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _Subtitle2 extends MaterialText {
  const _Subtitle2(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final subtitle2 = Theme.of(context).textTheme.subtitle2;
    return Text(
      text,
      style: style != null ? subtitle2?.merge(style) : subtitle2,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _Button extends MaterialText {
  const _Button(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final button = Theme.of(context).textTheme.button;
    return Text(
      text,
      style: style != null ? button?.merge(style) : button,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _Caption extends MaterialText {
  const _Caption(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final caption = Theme.of(context).textTheme.caption;
    return Text(
      text,
      style: style != null ? caption?.merge(style) : caption,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}

class _OverLine extends MaterialText {
  const _OverLine(String text,
      {Key? key,
      TextStyle? style,
      TextAlign? textAlign,
      bool? softWrap,
      TextOverflow? textOverflow,
      int? maxLines,
      Locale? locale,
      String? semanticsLabel,
      StrutStyle? strutStyle,
      TextDirection? textDirection,
      ui.TextHeightBehavior? textHeightBehavior,
      double? textScaleFactor,
      TextWidthBasis? textWidthBasis})
      : super(
          text,
          key: key,
          style: style,
          textAlign: textAlign,
          textWidthBasis: textWidthBasis,
          textScaleFactor: textScaleFactor,
          strutStyle: strutStyle,
          semanticsLabel: semanticsLabel,
          locale: locale,
          maxLines: maxLines,
          softWrap: softWrap,
          textDirection: textDirection,
          textHeightBehavior: textHeightBehavior,
          textOverflow: textOverflow,
        );

  @override
  Widget build(BuildContext context) {
    final overLine = Theme.of(context).textTheme.overline;
    return Text(
      text,
      style: style != null ? overLine?.merge(style) : overLine,
      textDirection: textDirection,
      overflow: textOverflow,
      maxLines: maxLines,
      textAlign: textAlign,
      softWrap: softWrap,
      locale: locale,
      semanticsLabel: semanticsLabel,
      strutStyle: strutStyle,
      textHeightBehavior: textHeightBehavior,
      textScaleFactor: textScaleFactor,
      textWidthBasis: textWidthBasis,
    );
  }
}
