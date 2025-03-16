import 'dart:math';

class UUID {
  Random _rng = Random();
  String generate() =>
      (_rng.nextDouble() * 1e16).toInt().toRadixString(16).padRight(14, '0');
}
