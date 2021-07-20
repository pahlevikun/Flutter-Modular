import 'package:core_utilities/src/common/sizer/size_config.dart';

extension SizeExt on num {
  double get h => this._toHeightPercentage;

  double get w => this._toWidthPercentage;

  double get sp => this._toFontPercentage;

  double get blockH => this._toHeightBlock;

  double get blockW => this._toWidthBlock;

  double get blockSp => this._toFontBlock;

  @Deprecated("Please consider to use 'xx.w' or 'xx.blockW'")
  double get toWidth => SizeConfig().getWidthRatio(this.toDouble());

  @Deprecated("Please consider to use 'xx.h' or 'xx.blockH'")
  double get toHeight => SizeConfig().getHeightRatio(this.toDouble());

  @Deprecated("Please consider to use 'xx.sp' or 'xx.blockSp'")
  double get toFont => SizeConfig().getFontRatio(this.toDouble());

  double get _toHeightPercentage =>
      SizeConfig().getPercentageHeightSize(this.toDouble());

  double get _toWidthPercentage =>
      SizeConfig().getPercentageWidthSize(this.toDouble());

  double get _toFontPercentage =>
      SizeConfig().getPercentageFontSize(this.toDouble());

  double get _toHeightBlock => SizeConfig().getVertical(this.toDouble());

  double get _toWidthBlock => SizeConfig().getHorizontal(this.toDouble());

  double get _toFontBlock => SizeConfig().getFont(this.toDouble());
}
