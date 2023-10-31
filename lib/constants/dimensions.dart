class Dimensions {
  static const double pageMargin = 16;
  static const double pageMarginHorizontal = 16;
  static const double pageMarginVertical = 16;
  static const double pageMarginHorizontalHalf = pageMarginHorizontal / 2;
  static const double pageMarginVerticalHalf = pageMarginVertical / 2;

  static const double bodyItemMargin = 8;
  static const double bodyItemPadding = 16;
  static const double bodyItemSpacer = 8;

  static const double containerRadius = 12;

  // avgMobileWidth - (2×pageMarginHorizontalHalf) - (2×bodyItemMargin)
  // 360 - (2×8) - (2×8)
  static const double cadQueryItemWidth = 328;
  static const double cadQueryItemBoxWidth =
      cadQueryItemWidth + 2 * bodyItemMargin;
  static const double cadQueryItemSpacing = 8;
  static const double cadResultItemSpacing = 8;

  static const double smallBodySelectorInputWidth = 150;

  // (avgMobileWidth - (4×bodyItemPadding) - (4×bodyItemMargin) - (2×pageMarginHorizontalHalf)) / 2
  // (360 − (4×16) − (4×8) − (2×8)) / 2
  static const double orgImageSize = 124;
  static const double orgItemWidth = orgImageSize + 2 * bodyItemPadding;
  static const double orgItemBoxWidth = orgItemWidth + 2 * bodyItemMargin;
}
