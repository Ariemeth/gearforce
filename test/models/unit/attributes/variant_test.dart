import 'package:flutter_test/flutter_test.dart';

import 'package:gearforce/src/pages/roster/models/unit/variant.dart';

void main() {
  group('Variant', () {
    test('should create Variant with correct properties', () {
      const variantId = 'variant-001';
      const variantName = 'Test Variant';
      const tv = 1;

      final variant = Variant(
        variantName,
        id: variantId,
        tv: tv,
        weapons: [],
        traits: [],
      );

      expect(variant.id, variantId);
      expect(variant.name, variantName);
      expect(variant.tv, tv);
      expect(variant.weapons, []);
      expect(variant.traits, []);
    });

    test('should throw assertion error for empty id', () {
      const emptyId = '';
      const variantName = 'Test Variant';
      const tv = 1;
      expect(() => Variant(variantName, id: emptyId, tv: tv),
          throwsAssertionError);
    });

    test('should throw assertion error for empty name', () {
      const variantId = 'variant-001';
      const emptyName = '';
      const tv = 1;
      expect(() => Variant(emptyName, id: variantId, tv: tv),
          throwsAssertionError);
    });

    test('should throw assertion error for negative TV', () {
      const variantId = 'variant-001';
      const variantName = 'Test Variant';
      const invalidTV = -1;
      expect(() => Variant(variantName, id: variantId, tv: invalidTV),
          throwsAssertionError);
    });
  });
}
