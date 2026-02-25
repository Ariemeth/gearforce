import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';

void main() {
  group('Movement', () {
    test('should create Movement with valid types and speed', () {
      final movementTypes = [MovementType.walker, MovementType.ground];
      const speed = 6;
      final movement = Movement(movementTypes, speed);
      expect(movement.types, movementTypes);
      expect(movement.value, speed);
    });

    test('should throw assertion error for negative speed', () {
      final movementTypes = [MovementType.walker];
      const invalidSpeed = -1;
      expect(() => Movement(movementTypes, invalidSpeed), throwsAssertionError);
    });
  });
}
