import 'dart:ui';

const double uiWidthDp = 375;

double getAdapterRatio() {
  return window.physicalSize.width / uiWidthDp;
}

double getAdapterRatioRatio() {
  return getAdapterRatio() / window.devicePixelRatio;
}

Size getScreenAdapterSize() {
  return Size(uiWidthDp, window.physicalSize.height / getAdapterRatio());
}
