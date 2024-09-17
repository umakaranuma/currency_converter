import 'package:flutter/material.dart';

// Colour Tokens
//GreyScale
Color background = const Color(0xFFF6F7FD);

Color surfacesubtitle = const Color(0xFFF7F9FF); // Grey/Surface/Subtle
Color surfaceDefault = const Color(0xFFF5F5F5); // Grey/Surface/Default
Color surfaceDisabled = const Color(0xFFF0F0F0); //Grey/Surface/Disabled
Color surfaceDarker = const Color(0xFF4B4B4B); //Grey/Surface/Darker

Color borderDefault = const Color(0xFFEFEFEF); //Grey/Border/Default
Color borderDisabled = const Color(0xFFF5F5F5); //Grey/Border/Diabled
Color borderDarker = const Color(0xFF5E5E5E); //Grey/Border/Darker

Color textTitle = const Color(0xFF1A1D1F); //Grey/Text/Title
Color textBody = const Color(0xFF5E5E5E); //Grey/Text/Body
Color textSubtitle = const Color(0xFF767676); //Grey/Text/Subtitle
Color textCaption = const Color(0xFF767676); //Grey/Text/Subtitle

//primary//Surface
Color primarySubtitle = const Color(0xffEAFBFC); //Surface/Primary/Subtle
Color primaryLighter = const Color(0xff66DDDD); //Surface/Primary/Lighter
Color primaryDefault = const Color(0xff1BB4BC); //Surface/Primary/Default
Color primaryDarker = const Color(0xff085F57); //Surface/Primary/Darker

//primary//Border
Color borderColor = const Color(0xffD0D5DD); //Border/Primary/Default
Color primaryBorderSubtitle = const Color(0xff99EEEE); //Border/Primary/Subtle
Color primaryBorderLighter = const Color(0xff33CCCC); //Border/Primary/Lighter
Color primaryBorderDefault = const Color(0xff1BB4BC); //Border/Primary/Default
Color primaryBorderDarker = const Color(0xff144540); //Border/Primary/Darker

//Text/Icon
Color primaryTextLabel = const Color(0xff1BB4BC); //Text/Primary/Label

//Border//Secondary
Color secondarySubtitle = const Color(0xffFBF7FB); //Surface/Secondary/Subtle
Color secondaryLighter = const Color(0xffF6EDF6); //Surface/Secondary/Lightst
Color secondaryDefault = const Color(0xff8B4387); //Surface/Secondary/Default
Color secondaryDarker = const Color(0xff5B2C59); //Border/Secondary/Darker

//Text/Icon
Color secondaryTextLabel = const Color(0xff8B4387); //Text/Secondary/Label

//Error
//Surface
Color errorSubtitle = const Color(0xffFDECEC); //Surface/Subtle
Color errorLighter = const Color(0xffF58E8E); //Surface/Lighter
Color errorDefault = const Color(0xffEF4444); //Surface/Default
Color errorDarker = const Color(0xffA90F0F); //Surface/Darker

//Border
Color errorBorderSubtitle = const Color(0xffFCD9D9); //Border/Subtle
Color errorBorderLighter = const Color(0xffF58E8E); //Border/Lighter
Color errorBorderDefault = const Color(0xffEF4444); //Border/Default
Color errorBorderDarker = const Color(0xffA90F0F); //Border/Darker

//Text/Icon
Color errorTextLabel = const Color(0xffA90F0F); //Text/Label

//Success/Surface
Color successSubtitle = const Color(0xffE9FBF0); //Surface/Subtle
Color successLighter = const Color(0xff6FE69B); //Surface/Lighter
Color successDefault = const Color(0xff22C55E); //Surface/Default
Color successDarker = const Color(0xff147538); //Surface/Darker

//Border
Color successBorderSubtitle = const Color(0xffCFF7DE); //Border/Subtle
Color successBorderLighter = const Color(0xff6FE69B); //Border/Lighter
Color successBorderDefault = const Color(0xff22C55E); //Border/Default
Color successBorderDarker = const Color(0xff147538); //Border/Darker

//Text Label
Color infoTextLabel = const Color(0xff3B82F6);
Color successTextLabel = const Color(0xff147538); //Text/Label

//Warning
//Surface
Color warningSubtitle = const Color(0xffFEF0E6); //Surface/Subtle
Color warningLighter = const Color(0xffFBAC74); //Surface/Lighter
Color warningDefault = const Color(0xffF97316); //Surface/Default
Color warningDarker = const Color(0xff9F4504); //Surface/Darker

//Border
Color warningBorderSubtitle = const Color(0xffFEE4D2); //Border/Subtle
Color warningBorderLighter = const Color(0xffFBAC74); //Border/Lighter
Color warningBorderDefault = const Color(0xffF97316); //Border/Default
Color warningBorderDarker = const Color(0xff9F4504); //Border/Darker

//Text/Label
Color warningTextLabel = const Color(0xff9F4504); //Text/Label

//Alert//Surface
Color alertSubtitle = const Color(0xffFFF9DB); //Surface/Alert/Subtle
Color alertLighter = const Color(0xffF2CA00); //Surface/Alert/Lighter
Color alertDefault = const Color(0xffD7B300); //Surface/Alert/Default
Color alertDarker = const Color(0xff6F5D00); //Surface/Alert/Darker

//Border

Color alertBorderSubtitle = const Color(0xffFFF1AB); //Border/Alert/Subtle
Color alertBorderLighter = const Color(0xffF2CA00); //Border/Alert/Lighter
Color alertBorderDefault = const Color(0xffAC8F00); //Border/Alert/Default
Color alertBorderDarker = const Color(0xff6F5D00); //Border/Alert/Darker

//Text/Icon
Color alertTextLabel = const Color(0xffAC8F00); //Text/Label

Color textNegative = const Color(0xffF5F5F5); //Grey/Text/Negative
Color textSmall = const Color(0xff000080);
Color textCaption2 = const Color(0xff49516F);

// Dark theme data
final ColorScheme darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: primaryDarker,
  onPrimary: Colors.white,
  secondary: secondaryDarker,
  onSecondary: Colors.white,
  error: errorDarker,
  onError: Colors.white,
  surface: surfaceDarker,
  onSurface: Colors.white,
  onTertiary: Colors.white,
  primaryContainer: primaryDarker,
  secondaryContainer: secondaryDarker,
  tertiary: primaryLighter,
  onTertiaryContainer: primaryLighter,
  surfaceTint: Colors.black,
);

// Light theme data
final ColorScheme lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: primaryDefault,
  onPrimary: Colors.white,
  secondary: secondaryDefault,
  onSecondary: primaryTextLabel,
  error: Colors.red,
  onError: Colors.white,
  surface: surfaceDefault,
  onSurface: const Color(0xff161D1C),
  onTertiary: Colors.white,
  primaryContainer: primaryLighter,
  secondaryContainer: secondaryLighter,
  tertiary: primaryLighter,
  onTertiaryContainer: primaryLighter,
  surfaceTint: primaryDefault,
);
