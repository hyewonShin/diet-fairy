import 'package:flutter/material.dart';

const primaryColor = Color(0xFF54A6FF);
const secondaryColor = Color(0xFF88CFEF);

final theme = ThemeData(
  colorScheme: const ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF54A6FF),
    onPrimary: Colors.white, // Primary 색상 위의 텍스트/아이콘 색상
    secondary: Color(0xFF88CFEF),
    onSecondary: Colors.white, // Secondary 색상 위의 텍스트/아이콘 색상
    error: Color(0xFFFF5C5C), // 오류 색상
    onError: Colors.white, // 오류 색상 위의 텍스트/아이콘 색상
    surface: Color(0xFFFFFFFF), // Card, Dialog 등의 배경 색상
    onSurface: Colors.black, // Surface 위의 텍스트 색상
  ),
  scaffoldBackgroundColor: const Color(0xFFF6F5F5),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: const TextStyle(
      color: Colors.grey,
    ),
    outlineBorder: const BorderSide(color: Colors.grey),
    border: OutlineInputBorder(
      borderSide: const BorderSide(color: Colors.grey),
      borderRadius: BorderRadius.circular(10),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        backgroundColor: primaryColor),
  ),
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Colors.transparent,
  ),
);
