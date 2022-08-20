import 'package:flutter/material.dart';
import 'package:rider/libraries/flutter_screenutil/flutter_screenutil.dart';

import '../../config/theme/colors.dart';

class TabBarViews extends StatefulWidget {
  const TabBarViews({Key? key, required this.items, required this.onTapChanged})
      : super(key: key);
  final List<TabBarModel> items;
  final ValueChanged<int> onTapChanged;

  @override
  _TabBarViewsState createState() => _TabBarViewsState();
}

class _TabBarViewsState extends State<TabBarViews> {
  late int savedIndex = 0;

  @override
  void initState() {
    // savedIndex = widget.items.indexWhere((element) => element.visible);
    widget.items[0].isChecked = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(widget.items.length, (index) {
        return _item(index);
      }),
    );
  }

  Widget _item(index) {
    return Visibility(
      visible: widget.items[index].visible,
      child: GestureDetector(
        onTap: () => click(index),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          clipBehavior: Clip.antiAlias,
          curve: Curves.easeIn,
          margin: EdgeInsets.symmetric(horizontal: 3.0.w, vertical: 3.r),
          constraints: BoxConstraints(
              maxWidth: widget.items[index].isChecked ? 90.0.w : 40.5.w,
              minWidth: 0),
          decoration: _boxDecoration(index),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              constraints: BoxConstraints(
                  maxWidth: widget.items[index].isChecked ? 90.0.w : 40.w,
                  minWidth: 0),
              decoration: const BoxDecoration(),
              clipBehavior: Clip.antiAlias,
              padding: EdgeInsets.all(5.r),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _svgIcon(index),
                  Flexible(child: _title(index)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _svgIcon(index) {
    return Icon(
      widget.items[index].path,
      size: 20.sp,
      color: widget.items[index].isChecked ? kWhite : kPRIMARY,
    );
  }

  BoxDecoration _boxDecoration(index) {
    return BoxDecoration(
        color:
            widget.items[index].isChecked ? kPRIMARY : kPRIMARY.withOpacity(.1),
        borderRadius: BorderRadius.circular(12.r));
  }

  Widget _title(index) {
    return Text(
      widget.items[index].isChecked ? widget.items[index].title : "",
      textAlign: TextAlign.center,
      style: TextStyle(
          color: widget.items[index].isChecked ? kWhite : kPRIMARY,
          fontWeight: FontWeight.w600,
          fontSize: 12.0.sp),
    );
  }

  click(index) {
    widget.onTapChanged(index);
    setState(() {
      if (savedIndex != index) {
        widget.items[savedIndex].isChecked &= false;
        widget.items[index].isChecked ^= true;
        savedIndex = index;
      }
    });
  }
}

class TabBarModel {
  late final String title;
  late final IconData path;
  bool isChecked;
  bool visible;

  TabBarModel(
      {required this.title,
      required this.path,
      this.isChecked = false,
      this.visible = true});
}
