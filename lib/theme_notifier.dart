// lib/components/themes.dart
import 'package:flutter/material.dart';

class AppColors {
  // Light mode
  static const Color lightPrimary = Colors.white;
  static const Color lightSecondary = Color(0xFF7E57C2); // Purple

  // Dark mode
  static const Color darkPrimary = Colors.black;
  static const Color darkSecondary = Color.fromARGB(
    255,
    250,
    159,
    22,
  ); // Orange
}

// Light Theme Gradient
LinearGradient kLightGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.lightPrimary,
    AppColors.lightSecondary.withOpacity(0.2),
    AppColors.lightSecondary.withOpacity(0.4),
  ],
);

// Dark Theme Gradient
LinearGradient kDarkGradient = LinearGradient(
  begin: Alignment.topLeft,
  end: Alignment.bottomRight,
  colors: [
    AppColors.darkPrimary,
    AppColors.darkSecondary.withOpacity(0.2),
    AppColors.darkSecondary.withOpacity(0.4),
  ],
);

class GradientBackground extends StatelessWidget {
  final Widget child;
  final bool isDark;

  const GradientBackground({
    Key? key,
    required this.child,
    required this.isDark,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: isDark ? kDarkGradient : kLightGradient,
      ),
      child: child,
    );
  }
}

// Dynamic text styles for contrasting themes
TextStyle dynamicTitle(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return TextStyle(
    color: isLight ? AppColors.darkSecondary : AppColors.lightSecondary,
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}

TextStyle dynamicBody(BuildContext context) {
  final isLight = Theme.of(context).brightness == Brightness.light;
  return TextStyle(
    color: isLight ? AppColors.darkPrimary : AppColors.lightPrimary,
    fontSize: 14,
  );
}

// Theme Provider
class ThemeProvider with ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  void toggleTheme(bool isDark) {
    _themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

final ThemeData lightTheme = ThemeData(
  brightness: Brightness.light,
  primaryColor: AppColors.lightPrimary,
  scaffoldBackgroundColor: AppColors.lightPrimary,
  colorScheme: const ColorScheme.light().copyWith(
    primary: AppColors.lightPrimary,
    secondary: AppColors.lightSecondary,
  ),
);

final ThemeData darkTheme = ThemeData(
  brightness: Brightness.dark,
  primaryColor: AppColors.darkPrimary,
  scaffoldBackgroundColor: AppColors.darkPrimary,
  colorScheme: const ColorScheme.dark().copyWith(
    primary: AppColors.darkPrimary,
    secondary: AppColors.darkSecondary,
  ),
);

class ThemeNotifier extends ChangeNotifier {
  ThemeMode _currentTheme = ThemeMode.light;

  ThemeMode get currentTheme => _currentTheme;

  void toggleTheme() {
    _currentTheme = _currentTheme == ThemeMode.light
        ? ThemeMode.dark
        : ThemeMode.light;
    notifyListeners();
  }
}
