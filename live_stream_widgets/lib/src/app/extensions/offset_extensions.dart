import 'package:flutter/rendering.dart';

/// Расширения для удобства работы с Offset
extension OffsetExtensions on Offset {
  /// Скалярное произведение двух векторов
  double dot(Offset other) => dx * other.dx + dy * other.dy;

  /// Квадрат расстояния (для оптимизации вычислений)
  double get distanceSquared => dx * dx + dy * dy;

  /// Нормализует вектор (делит на длину)
  Offset normalize() {
    final d = distance;
    return d == 0 ? this : this / d;
  }
}
