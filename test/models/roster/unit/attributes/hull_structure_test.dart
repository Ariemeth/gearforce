import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';

void main() {
  group('HullStructure', () {
    test('should create HullStructure with valid values', () {
      const validHull = 4;
      const validStructure = 3;
      const hullStructure = HullStructure(
        hull: validHull,
        structure: validStructure,
      );
      expect(hullStructure.hull, validHull);
      expect(hullStructure.structure, validStructure);
    });

    test('should throw assertion error for negative hull or structure', () {
      const invalidHull = -1;
      const validStructure = 3;
      const validHull = 4;
      const invalidStructure = -1;

      expect(
        () => HullStructure(hull: invalidHull, structure: validStructure),
        throwsAssertionError,
      );
      expect(
        () => HullStructure(hull: validHull, structure: invalidStructure),
        throwsAssertionError,
      );
    });
  });
}
