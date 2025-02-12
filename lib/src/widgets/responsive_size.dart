enum ScreenSize {
  small,
  large,
}

class ResponsiveSize {
  static ScreenSize getScreenSize(double width) {
    if (width < 1000) {
      return ScreenSize.small;
    }
    return ScreenSize.large;
  }
}
