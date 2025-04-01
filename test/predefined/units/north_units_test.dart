import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/predefined/units/north_models.dart';

void main() {
  group('North Units', () {
    test('should have unique IDs for all units, upgrades, and variants', () {
      final units = NorthUnits.getUnits();

      // Check that all unit IDs are unique
      final unitIds = units.map((unit) => unit.id).toList();
      final duplicateUnitIds = unitIds
          .where((id) => unitIds.where((x) => x == id).length > 1)
          .toSet();
      expect(duplicateUnitIds.isEmpty, true,
          reason: 'Duplicate Unit IDs found: $duplicateUnitIds');

      for (final unit in units) {
        // Check that all variant IDs within a unit are unique
        final variantIds = unit.variants.map((variant) => variant.id).toList();
        final duplicateVariantIds = variantIds
            .where((id) => variantIds.where((x) => x == id).length > 1)
            .toSet();
        expect(duplicateVariantIds.isEmpty, true,
            reason:
                'Duplicate Variant IDs for unit "${unit.name}" found: $duplicateVariantIds');
      }
    });
  });
}
