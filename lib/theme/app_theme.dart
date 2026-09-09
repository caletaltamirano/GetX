import 'package:flutter/material.dart';

/// ===========================================================================
///  TEMA / APARIENCIA DE LA APP
/// ===========================================================================
///
/// Aquí vive TODO lo visual (colores, sombras, bordes redondeados, estilos de
/// texto). Lo separamos del resto para que los widgets no tengan colores
/// "sueltos" y sea fácil cambiar el look en un solo lugar.
///
/// Este archivo NO tiene nada de GetX: es puro Flutter.
class AppColors {
  AppColors._(); // clase solo de constantes, no se instancia

  /// Fondo morado de toda la pantalla (como el "escritorio" del diseño).
  static const Color background = Color(0xFF6E62E8);

  /// Blanco de las tarjetas grandes.
  static const Color surface = Color(0xFFFFFFFF);

  /// Gris muy claro para paneles internos suaves.
  static const Color surfaceSoft = Color(0xFFF4F3FC);

  /// Morado/índigo principal: botones, íconos activos, acentos.
  static const Color primary = Color(0xFF5B5FEF);

  /// Azul marino oscuro (títulos, tarjeta "Total").
  static const Color navy = Color(0xFF302C6B);

  /// Naranja de acento (la "insignia" con el número de pendientes).
  static const Color accent = Color(0xFFFF6B35);

  /// Texto oscuro principal.
  static const Color textDark = Color(0xFF2D2A45);

  /// Texto gris secundario (subtítulos, ayudas).
  static const Color textMuted = Color(0xFF9C9AB3);

  // --- Degradados para las tarjetas de estadísticas -----------------------
  static const List<Color> gradIndigo = [Color(0xFF6C5CE7), Color(0xFF9B8CFF)];
  static const List<Color> gradCoral = [Color(0xFFFF6B9D), Color(0xFFFFA07A)];
  static const List<Color> gradGreen = [Color(0xFF20C997), Color(0xFF63E6BE)];
}

/// Valores de forma reutilizables (bordes redondeados).
class AppRadius {
  AppRadius._();

  static const BorderRadius card = BorderRadius.all(Radius.circular(28));
  static const BorderRadius panel = BorderRadius.all(Radius.circular(20));
  static const BorderRadius tile = BorderRadius.all(Radius.circular(16));
  static const BorderRadius field = BorderRadius.all(Radius.circular(16));
}

/// Sombra suave con tinte morado, igual que las tarjetas del diseño.
const List<BoxShadow> kSoftShadow = [
  BoxShadow(
    color: Color(0x1A6C5CE7), // morado con ~10% de opacidad
    blurRadius: 30,
    offset: Offset(0, 14),
  ),
];

/// Tema Material 3 completo de la app. Se conecta en `main.dart`.
class AppTheme {
  AppTheme._();

  static ThemeData get light {
    final base = ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
        primary: AppColors.primary,
        surface: AppColors.surface,
      ),
      scaffoldBackgroundColor: AppColors.background,
    );

    return base.copyWith(
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.textDark,
        displayColor: AppColors.textDark,
      ),

      // Campo de texto: relleno gris claro, sin bordes duros, esquinas redondas.
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceSoft,
        hintStyle: const TextStyle(color: AppColors.textMuted),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: const OutlineInputBorder(
          borderRadius: AppRadius.field,
          borderSide: BorderSide.none,
        ),
        enabledBorder: const OutlineInputBorder(
          borderRadius: AppRadius.field,
          borderSide: BorderSide.none,
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: AppRadius.field,
          borderSide: BorderSide(color: AppColors.primary, width: 1.5),
        ),
      ),

      iconButtonTheme: IconButtonThemeData(
        style: IconButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: const RoundedRectangleBorder(borderRadius: AppRadius.tile),
          padding: const EdgeInsets.all(14),
        ),
      ),

      dividerTheme: const DividerThemeData(
        color: Color(0xFFEDECF6),
        thickness: 1,
        space: 1,
      ),
    );
  }
}
