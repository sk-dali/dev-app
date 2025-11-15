import 'package:flutter/material.dart';
import 'material_theme.dart';

class AppTheme {
  static ThemeData get theme {
    // テキストテーマを定義
    const textTheme = TextTheme(
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      titleMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w600,
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
      ),
    );

    // MaterialThemeを使用してテーマを生成
    final materialTheme = MaterialTheme(textTheme);
    return materialTheme.light();
  }
}

