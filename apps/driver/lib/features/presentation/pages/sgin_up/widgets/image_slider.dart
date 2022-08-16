import 'package:design/design.dart';
import 'package:image_picker/image_picker.dart';

import 'invoice_image_view.dart';

class ImageSliderView extends StatefulWidget {
  final XFile ?images;
  final Function() removeImageTap;
  final int index;

  const ImageSliderView(
      {Key? key,
      required this.images,
      required this.index,
      required this.removeImageTap})
      : super(key: key);

  @override
  State<ImageSliderView> createState() => _ImageSliderViewState();
}

class _ImageSliderViewState extends State<ImageSliderView> {
  PageController? pageController;
  double opacity1 = 0.0;
  double opacity3 = 0.0;
  late int index;

  @override
  void initState() {
    super.initState();
    index = widget.index;
    pageController = PageController(initialPage: widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
                top: 10,
                left: 10,
                child: _button(() async {
                  Navigator.of(context).pop();
                }, Icons.arrow_forward_ios)),
            SPadding(
              padding: const EdgeInsets.symmetric(vertical: 70),
              child:   InvoiceImageView(
                      image: widget.images,
                    )
            ),
          
          
          ],
        ),
      ),
    );
  }

  _next() {
    pageController!.nextPage(
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
  }

  _back() {
    pageController!.previousPage(
        duration: const Duration(milliseconds: 250), curve: Curves.linear);
  }

  _button(VoidCallback onTap, IconData iconData) {
    return Material(
      borderRadius: BorderRadius.circular(12),
      elevation: 1,
      color: kGrey2,
      child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: onTap,
          child: SPadding.all8(child: Icon(iconData))),
    );
  }

  Widget _circleButton(
      {required IconData iconData, required void Function() onPress}) {
    return RawMaterialButton(
      onPressed: onPress,
      elevation: 0,
      fillColor: kPrimaryColor,
      shape: const CircleBorder(),
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      padding: const EdgeInsets.all(12),
      child: Icon(
        iconData,
        color: kWhite,
        size: 20,
      ),
    );
  }
}
