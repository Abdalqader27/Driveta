import 'package:design/design.dart';
import 'package:driver/common/config/theme/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MapAppBarWidget extends StatefulWidget {
  const MapAppBarWidget({
    Key? key,
    required this.onChanged,
    required this.title,
    this.onPressed,
  }) : super(key: key);
  final ValueChanged<bool>? onChanged;
  final VoidCallback? onPressed;

  final String title;

  @override
  _MapAppBarWidgetState createState() => _MapAppBarWidgetState();
}

class _MapAppBarWidgetState extends State<MapAppBarWidget> {
  bool valueChanged = false;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.5,
      backgroundColor: Colors.white,
      centerTitle: true,
      title: SText.titleMedium(widget.title),
      actions: [
        CupertinoSwitch(
          activeColor: kPRIMARY,
          value: valueChanged,
          onChanged: (value) {
            setState(() => valueChanged = value);
            widget.onChanged!(value);
          },
        )
      ],
      leading: IconButton(
        onPressed: widget.onPressed,
        icon: const Icon(
          Icons.menu,
          color: kPRIMARY,
        ),
      ),
    );
  }
}
