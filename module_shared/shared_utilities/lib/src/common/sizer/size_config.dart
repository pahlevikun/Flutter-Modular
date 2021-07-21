import 'package:flutter/widgets.dart';

class SizeConfig {
  static final SizeConfig _singleton = SizeConfig._internal();

  factory SizeConfig() {
    return _singleton;
  }

  SizeConfig._internal();

  static late MediaQueryData _mediaQueryData;
  static late double _screenWidth;
  static late double _screenHeight;
  static late double _blockSizeHorizontal;
  static late double _blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double _safeBlockHorizontal;
  static late double _safeBlockVertical;
  static late double _refHeight;
  static late double _refWidth;
  static late DeviceType _deviceType;

  void init(BuildContext context, BoxConstraints constraints,
      Orientation orientation) {
    _mediaQueryData = MediaQuery.of(context);
    _screenWidth = _mediaQueryData.size.width;
    _screenHeight = _mediaQueryData.size.height;
    _refHeight = 1450;
    _refWidth = 670;

    if (_screenWidth < 600) {
      _deviceType = DeviceType.Mobile;
    } else {
      _deviceType = DeviceType.Tablet;
    }

    if (_screenHeight < 1200) {
      _blockSizeHorizontal = _screenWidth / 100;
      _blockSizeVertical = _screenWidth / 100;

      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

      _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 100;
      _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 100;
    } else {
      _blockSizeHorizontal = _screenWidth / 120;
      _blockSizeVertical = _screenHeight / 120;

      _safeAreaHorizontal =
          _mediaQueryData.padding.left + _mediaQueryData.padding.right;
      _safeAreaVertical =
          _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

      _safeBlockHorizontal = (_screenWidth - _safeAreaHorizontal) / 120;
      _safeBlockVertical = (_screenHeight - _safeAreaVertical) / 120;
    }
  }

  @Deprecated(
      "Deprecated, this now become not accurate, please use SizeConfigExt")
  double getFont(block) {
    if (block is double || block is int) {
      return _safeBlockHorizontal * block;
    }
    throw ArgumentError("Invalid argument (block): Should use double or int");
  }

  @Deprecated(
      "Deprecated, this now become not accurate, please use SizeConfigExt")
  double getHorizontal(block) {
    if (block is double || block is int) {
      return _safeBlockHorizontal * block;
    }
    throw ArgumentError("Invalid argument (block): Should use double or int");
  }

  @Deprecated(
      "Deprecated, this now become not accurate, please use SizeConfigExt")
  double getVertical(block) {
    if (block is double || block is int) {
      return _safeBlockVertical * block;
    }
    throw ArgumentError("Invalid argument (block): Should use double or int");
  }

  @Deprecated(
      "Deprecated, this now become not accurate, please use SizeConfigExt")
  double getPercentageHeightSize(double percent) =>
      percent > 100 || percent < 0 ? 0 : _screenHeight * (percent / 100);

  @Deprecated(
      "Deprecated, this now become not accurate, please use SizeConfigExt")
  double getPercentageWidthSize(double percent) =>
      percent > 100 || percent < 0 ? 0 : _screenWidth * percent;

  double getPercentageFontSize(double percent) {
    return _screenWidth / 100 * (percent / 3);
  }

  DeviceType getDeviceType() => _deviceType;

  double getScreenHeight() => _screenHeight;

  double getScreenWidth() => _screenWidth;

  double getBlockSizeHorizontal() => _blockSizeHorizontal;

  double getBlockSizeVertical() => _blockSizeVertical;

  double getWidthRatio(double val) {
    double res = (val / _refWidth) * 100;
    double temp = res * _blockSizeHorizontal;
    return temp;
  }

  double getHeightRatio(double val) {
    double res = (val / _refHeight) * 100;
    double temp = res * _blockSizeVertical;
    return temp;
  }

  double getFontRatio(double val) {
    double res = (val / _refWidth) * 100;
    double temp = 0.0;
    if (_screenWidth < _screenHeight) {
      temp = res * _safeBlockHorizontal;
    } else {
      temp = res * _safeBlockVertical;
    }

    return temp;
  }
}

enum DeviceType {
  Mobile,
  Tablet,
}
