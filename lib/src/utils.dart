import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

TextTheme createTextTheme(BuildContext context, String bodyFontString,
    String displayFontString) {
  TextTheme baseTextTheme = Theme
      .of(context)
      .textTheme;
  TextTheme bodyTextTheme = GoogleFonts.getTextTheme(
      bodyFontString, baseTextTheme);
  TextTheme displayTextTheme =
  GoogleFonts.getTextTheme(displayFontString, baseTextTheme);
  TextTheme textTheme = displayTextTheme.copyWith(
    bodyLarge: bodyTextTheme.bodyLarge,
    bodyMedium: bodyTextTheme.bodyMedium,
    bodySmall: bodyTextTheme.bodySmall,
    labelLarge: bodyTextTheme.labelLarge,
    labelMedium: bodyTextTheme.labelMedium,
    labelSmall: bodyTextTheme.labelSmall,
  );
  return textTheme;
}

Brightness getBrightnessForThemeMode(ThemeMode mode) {
  return mode == ThemeMode.light ? Brightness.light : Brightness.dark;
}

ColorScheme lightScheme() {
return const ColorScheme(
brightness: Brightness.light,
primary: Color(4285357583),
surfaceTint: Color(4285357583),
onPrimary: Color(4294967295),
primaryContainer: Color(4294500999),
onPrimaryContainer: Color(4280425216),
secondary: Color(4284898880),
onSecondary: Color(4294967295),
secondaryContainer: Color(4293845692),
onSecondaryContainer: Color(4280359684),
tertiary: Color(4282607182),
onTertiary: Color(4294967295),
tertiaryContainer: Color(4291161294),
onTertiaryContainer: Color(4278198543),
error: Color(4290386458),
onError: Color(4294967295),
errorContainer: Color(4294957782),
onErrorContainer: Color(4282449922),
surface: Color(4294965742),
onSurface: Color(4280163091),
onSurfaceVariant: Color(4283123513),
outline: Color(4286347111),
outlineVariant: Color(4291675828),
shadow: Color(4278190080),
scrim: Color(4278190080),
inverseSurface: Color(4281544743),
inversePrimary: Color(4292593262),
primaryFixed: Color(4294500999),
onPrimaryFixed: Color(4280425216),
primaryFixedDim: Color(4292593262),
onPrimaryFixedVariant: Color(4283647488),
secondaryFixed: Color(4293845692),
onSecondaryFixed: Color(4280359684),
secondaryFixedDim: Color(4291937953),
onSecondaryFixedVariant: Color(4283320106),
tertiaryFixed: Color(4291161294),
onTertiaryFixed: Color(4278198543),
tertiaryFixedDim: Color(4289319091),
onTertiaryFixedVariant: Color(4281093688),
surfaceDim: Color(4292925900),
surfaceBright: Color(4294965742),
surfaceContainerLowest: Color(4294967295),
surfaceContainerLow: Color(4294636517),
surfaceContainer: Color(4294241759),
surfaceContainerHigh: Color(4293847258),
surfaceContainerHighest: Color(4293452500),
);
}

ColorScheme darkScheme() {
return const ColorScheme(
brightness: Brightness.dark,
primary: Color(4292593262),
surfaceTint: Color(4292593262),
onPrimary: Color(4282003456),
primaryContainer: Color(4283647488),
onPrimaryContainer: Color(4294500999),
secondary: Color(4291937953),
onSecondary: Color(4281741334),
secondaryContainer: Color(4283320106),
onSecondaryContainer: Color(4293845692),
tertiary: Color(4289319091),
onTertiary: Color(4279514915),
tertiaryContainer: Color(4281093688),
onTertiaryContainer: Color(4291161294),
error: Color(4294948011),
onError: Color(4285071365),
errorContainer: Color(4287823882),
onErrorContainer: Color(4294957782),
surface: Color(4279571211),
onSurface: Color(4293452500),
onSurfaceVariant: Color(4291675828),
outline: Color(4288057472),
outlineVariant: Color(4283123513),
shadow: Color(4278190080),
scrim: Color(4278190080),
inverseSurface: Color(4293452500),
inversePrimary: Color(4285357583),
primaryFixed: Color(4294500999),
onPrimaryFixed: Color(4280425216),
primaryFixedDim: Color(4292593262),
onPrimaryFixedVariant: Color(4283647488),
secondaryFixed: Color(4293845692),
onSecondaryFixed: Color(4280359684),
secondaryFixedDim: Color(4291937953),
onSecondaryFixedVariant: Color(4283320106),
tertiaryFixed: Color(4291161294),
onTertiaryFixed: Color(4278198543),
tertiaryFixedDim: Color(4289319091),
onTertiaryFixedVariant: Color(4281093688),
surfaceDim: Color(4279571211),
surfaceBright: Color(4282136880),
surfaceContainerLowest: Color(4279242247),
surfaceContainerLow: Color(4280163091),
surfaceContainer: Color(4280426519),
surfaceContainerHigh: Color(4281149985),
surfaceContainerHighest: Color(4281873707),
);
}
