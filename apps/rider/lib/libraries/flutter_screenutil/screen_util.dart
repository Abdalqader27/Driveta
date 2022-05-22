/*
 * Created by 李卓原 on 2018/9/29.
 * email: zhuoyuan93@gmail.com
 */
part of flutter_screenutil;

class ScreenUtil {
  static const Size defaultSize = Size(360, 690);
  static late ScreenUtil _instance;

  /// UI设计中手机尺寸 , dp
  /// Size of the phone in UI Design , dp
  late Size uiSize;

  ///屏幕方向
  late Orientation _orientation;

  late double _pixelRatio;
  late double _textScaleFactor;
  late double _screenWidth;
  late double _screenHeight;
  late double _statusBarHeight;
  late double _bottomBarHeight;

  ScreenUtil._();

  factory ScreenUtil() {
    return _instance;
  }

  static void init(
    BoxConstraints constraints, {
    Orientation orientation = Orientation.portrait,
    Size designSize = defaultSize,
  }) {
    _instance = ScreenUtil._()
      ..uiSize = designSize
      .._orientation = orientation
      .._screenWidth = orientation == Orientation.portrait ? constraints.maxWidth : constraints.maxHeight
      .._screenHeight = orientation == Orientation.landscape ? constraints.maxWidth : constraints.maxHeight;

    var window = WidgetsBinding.instance.window;
    _instance._pixelRatio = window.devicePixelRatio;
    _instance._statusBarHeight = window.padding.top;
    _instance._bottomBarHeight = window.padding.bottom;
    _instance._textScaleFactor = window.textScaleFactor;
  }

  ///获取屏幕方向
  ///Get screen orientation
  Orientation get orientation => _orientation;

  /// 每个逻辑像素的字体像素数，字体的缩放比例
  /// The number of font pixels for each logical pixel.
  double get textScaleFactor => _textScaleFactor;

  /// 设备的像素密度
  /// The size of the media in logical pixels (e.g, the size of the screen).
  double get pixelRatio => _pixelRatio;

  /// 当前设备宽度 dp
  /// The horizontal extent of this size.
  double get screenWidth => _screenWidth;

  ///当前设备高度 dp
  ///The vertical extent of this size. dp
  double get screenHeight => _screenHeight;

  /// 状态栏高度 dp 刘海屏会更高
  /// The offset from the top, in dp
  double get statusBarHeight => _statusBarHeight / _pixelRatio;

  /// 底部安全区距离 dp
  /// The offset from the bottom, in dp
  double get bottomBarHeight => _bottomBarHeight / _pixelRatio;

  /// 实际尺寸与UI设计的比例
  /// The ratio of actual width to UI design
  double get scaleWidth => _screenWidth / uiSize.width;

  ///  /// The ratio of actual height to UI design
  double get scaleHeight => _screenHeight / uiSize.height;

  double get scaleText => min(scaleWidth, scaleHeight);

  /// 根据UI设计的设备宽度适配
  /// 高度也可以根据这个来做适配可以保证不变形,比如你想要一个正方形的时候.
  /// Adapted to the device width of the UI Design.
  /// Height can also be adapted according to this to ensure no deformation ,
  /// if you want a square
  double setWidth(num width) => width * scaleWidth;

  /// 根据UI设计的设备高度适配
  /// 当发现UI设计中的一屏显示的与当前样式效果不符合时,
  /// 或者形状有差异时,建议使用此方法实现高度适配.
  /// 高度适配主要针对想根据UI设计的一屏展示一样的效果
  /// Highly adaptable to the device according to UI Design
  /// It is recommended to use this method to achieve a high degree of adaptation
  /// when it is found that one screen in the UI design
  /// does not match the current style effect, or if there is a difference in shape.
  double setHeight(num height) => height * scaleHeight;

  ///根据宽度或高度中的较小值进行适配
  ///Adapt according to the smaller of width or height
  double radius(num r) => r * scaleText;

  ///字体大小适配方法
  ///- [fontSize] UI设计上字体的大小,单位dp.
  ///Font size adaptation method
  ///- [fontSize] The size of the font on the UI design, in dp.
  double setSp(num fontSize) => fontSize * scaleText;
}
