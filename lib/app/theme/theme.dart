import 'package:flutter_postman/app/theme/light_theme.dart';
import 'package:flutter_postman/app/theme/theme_colors.dart';

export './dark_theme.dart';
export './light_theme.dart';
export './theme_colors.dart';

ThemeColors _themeColors = LightTheme();

ThemeColors get themeColors => _themeColors;

void setThemeColors(ThemeColors themeColors) {
  _themeColors = themeColors;
}
