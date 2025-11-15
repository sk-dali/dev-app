import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff775083),
      surfaceTint: Color(0xff775083),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xfff9d8ff),
      onPrimaryContainer: Color(0xff5e386a),
      secondary: Color(0xff69596c),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xfff2dcf3),
      onSecondaryContainer: Color(0xff514254),
      tertiary: Color(0xff82524f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffdad7),
      onTertiaryContainer: Color(0xff663b38),
      error: Color(0xffba1a1a),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad6),
      onErrorContainer: Color(0xff93000a),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff1f1a1f),
      onSurfaceVariant: Color(0xff4c444d),
      outline: Color(0xff7d747d),
      outlineVariant: Color(0xffcfc3cd),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe6b6f2),
      primaryFixed: Color(0xfff9d8ff),
      onPrimaryFixed: Color(0xff2e0a3c),
      primaryFixedDim: Color(0xffe6b6f2),
      onPrimaryFixedVariant: Color(0xff5e386a),
      secondaryFixed: Color(0xfff2dcf3),
      onSecondaryFixed: Color(0xff241727),
      secondaryFixedDim: Color(0xffd5c0d7),
      onSecondaryFixedVariant: Color(0xff514254),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff331110),
      tertiaryFixedDim: Color(0xfff5b7b3),
      onTertiaryFixedVariant: Color(0xff663b38),
      surfaceDim: Color(0xffe1d7de),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf1f8),
      surfaceContainer: Color(0xfff5ebf2),
      surfaceContainerHigh: Color(0xffefe5ed),
      surfaceContainerHighest: Color(0xffeae0e7),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff4c2758),
      surfaceTint: Color(0xff775083),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff875e93),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff403143),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff79677c),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff532b29),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff92605d),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff740006),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffcf2c27),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff141015),
      onSurfaceVariant: Color(0xff3b343c),
      outline: Color(0xff585058),
      outlineVariant: Color(0xff736a73),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe6b6f2),
      primaryFixed: Color(0xff875e93),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff6d4679),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff79677c),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5f4f63),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff92605d),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff774846),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcdc4cb),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfffbf1f8),
      surfaceContainer: Color(0xffefe5ed),
      surfaceContainerHigh: Color(0xffe4dae1),
      surfaceContainerHighest: Color(0xffd8cfd6),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff411d4d),
      surfaceTint: Color(0xff775083),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff603a6d),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff352739),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff534457),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff47211f),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff693d3b),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff600004),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff98000a),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffff7fb),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff312a32),
      outlineVariant: Color(0xff4e474f),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff342f34),
      inversePrimary: Color(0xffe6b6f2),
      primaryFixed: Color(0xff603a6d),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff482454),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff534457),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff3c2e3f),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff693d3b),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff4f2725),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbfb6bd),
      surfaceBright: Color(0xfffff7fb),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff8eef5),
      surfaceContainer: Color(0xffeae0e7),
      surfaceContainerHigh: Color(0xffdbd2d9),
      surfaceContainerHighest: Color(0xffcdc4cb),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe6b6f2),
      surfaceTint: Color(0xffe6b6f2),
      onPrimary: Color(0xff452152),
      primaryContainer: Color(0xff5e386a),
      onPrimaryContainer: Color(0xfff9d8ff),
      secondary: Color(0xffd5c0d7),
      onSecondary: Color(0xff3a2c3d),
      secondaryContainer: Color(0xff514254),
      onSecondaryContainer: Color(0xfff2dcf3),
      tertiary: Color(0xfff5b7b3),
      onTertiary: Color(0xff4c2523),
      tertiaryContainer: Color(0xff663b38),
      onTertiaryContainer: Color(0xffffdad7),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      errorContainer: Color(0xff93000a),
      onErrorContainer: Color(0xffffdad6),
      surface: Color(0xff161217),
      onSurface: Color(0xffeae0e7),
      onSurfaceVariant: Color(0xffcfc3cd),
      outline: Color(0xff988e97),
      outlineVariant: Color(0xff4c444d),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae0e7),
      inversePrimary: Color(0xff775083),
      primaryFixed: Color(0xfff9d8ff),
      onPrimaryFixed: Color(0xff2e0a3c),
      primaryFixedDim: Color(0xffe6b6f2),
      onPrimaryFixedVariant: Color(0xff5e386a),
      secondaryFixed: Color(0xfff2dcf3),
      onSecondaryFixed: Color(0xff241727),
      secondaryFixedDim: Color(0xffd5c0d7),
      onSecondaryFixedVariant: Color(0xff514254),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff331110),
      tertiaryFixedDim: Color(0xfff5b7b3),
      onTertiaryFixedVariant: Color(0xff663b38),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff3d373d),
      surfaceContainerLowest: Color(0xff110d12),
      surfaceContainerLow: Color(0xff1f1a1f),
      surfaceContainer: Color(0xff231e23),
      surfaceContainerHigh: Color(0xff2d282e),
      surfaceContainerHighest: Color(0xff383339),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff7cfff),
      surfaceTint: Color(0xffe6b6f2),
      onPrimary: Color(0xff391646),
      primaryContainer: Color(0xffad81b9),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffebd6ed),
      onSecondary: Color(0xff2e2132),
      secondaryContainer: Color(0xff9d8ba0),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd2ce),
      onTertiary: Color(0xff3f1b19),
      tertiaryContainer: Color(0xffba837f),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2cc),
      onError: Color(0xff540003),
      errorContainer: Color(0xffff5449),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe5d9e3),
      outline: Color(0xffbaafb8),
      outlineVariant: Color(0xff978d97),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae0e7),
      inversePrimary: Color(0xff5f396b),
      primaryFixed: Color(0xfff9d8ff),
      onPrimaryFixed: Color(0xff220030),
      primaryFixedDim: Color(0xffe6b6f2),
      onPrimaryFixedVariant: Color(0xff4c2758),
      secondaryFixed: Color(0xfff2dcf3),
      onSecondaryFixed: Color(0xff190d1c),
      secondaryFixedDim: Color(0xffd5c0d7),
      onSecondaryFixedVariant: Color(0xff403143),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff250707),
      tertiaryFixedDim: Color(0xfff5b7b3),
      onTertiaryFixedVariant: Color(0xff532b29),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff494348),
      surfaceContainerLowest: Color(0xff0a060a),
      surfaceContainerLow: Color(0xff211c21),
      surfaceContainer: Color(0xff2b262c),
      surfaceContainerHigh: Color(0xff363136),
      surfaceContainerHighest: Color(0xff423c42),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfffeeaff),
      surfaceTint: Color(0xffe6b6f2),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffe2b2ed),
      onPrimaryContainer: Color(0xff190025),
      secondary: Color(0xfffeeaff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffd1bcd3),
      onSecondaryContainer: Color(0xff120716),
      tertiary: Color(0xffffecea),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfff1b3af),
      onTertiaryContainer: Color(0xff1e0303),
      error: Color(0xffffece9),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea4),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff161217),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff9ecf7),
      outlineVariant: Color(0xffcbbfc9),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffeae0e7),
      inversePrimary: Color(0xff5f396b),
      primaryFixed: Color(0xfff9d8ff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffe6b6f2),
      onPrimaryFixedVariant: Color(0xff220030),
      secondaryFixed: Color(0xfff2dcf3),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffd5c0d7),
      onSecondaryFixedVariant: Color(0xff190d1c),
      tertiaryFixed: Color(0xffffdad7),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xfff5b7b3),
      onTertiaryFixedVariant: Color(0xff250707),
      surfaceDim: Color(0xff161217),
      surfaceBright: Color(0xff544e54),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff231e23),
      surfaceContainer: Color(0xff342f34),
      surfaceContainerHigh: Color(0xff3f3a3f),
      surfaceContainerHighest: Color(0xff4b454b),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.background,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}

