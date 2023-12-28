import "package:flutter/material.dart";

class AppTheme {
  ThemeData get themeData => ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.deepPurple,
      primary: Color(0xFF2a3745), // Azul Oscuro Profundo
      secondary: Color(0xFF63675c), // Gris Verdoso
      surface: Color(0xFF52544a), // Gris Pizarra
      background: Color(0xFFdfbf8f), // Beige Suave
      error: Color(0xFF875946), // Marrón Terracota
      onPrimary: Color(0xFF46383b), // Marrón Oscuro
      onSecondary: Color(0xFF1e1d25), // Negro Azabache
      onSurface: Color(0xFF1e1d25), // Negro Azabache (repetido)
      onBackground: Color(0xFF1e1d25), // Negro Azabache (repetido)
      onError: Color(0xFF1e1d25), // Negro Azabache (puedes elegir otro si quieres variar)
    ),
    useMaterial3: true,
  );
}
