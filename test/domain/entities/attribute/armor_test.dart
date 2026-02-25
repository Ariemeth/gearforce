import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';

void main() {
  group('Armor', () {
    test('should create Armor with valid value', () {
      const validArmorValue = 5;
      const armor = Armor(validArmorValue);
      expect(armor.value, validArmorValue);
    });

    test('should throw assertion error for negative value', () {
      const invalidArmorValue = -1;
      expect(() => Armor(invalidArmorValue), throwsAssertionError);
    });

    test('toString should return "-" for value 0', () {
      const zeroArmorValue = 0;
      const armor = Armor(zeroArmorValue);
      expect(armor.toString(), '-');
    });

    test('toString should return value as string for non-zero value', () {
      const nonZeroArmorValue = 5;
      const armor = Armor(nonZeroArmorValue);
      expect(armor.toString(), '$nonZeroArmorValue');
    });
  });
}
