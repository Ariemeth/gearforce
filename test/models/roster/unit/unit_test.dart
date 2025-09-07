import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/classification.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/model_base.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/models/roster/unit/variant.dart';

void main() {
  group('Unit', () {
    test('should create a Unit with correct properties', () {
      const unitName = 'Test Unit';
      const unitId = 'unit-001';
      const unitTV = 10;
      const unitClassification = Classification.gear;
      const unitSubtype = 'Test Subtype';
      const unitManufacturer = 'Test Manufacturer';
      const unitDescription = 'This is a test unit.';
      const variant1Id = 'variant-001';
      const variant1Name = 'Variant 1';
      const variant2Id = 'variant-002';
      const variant2Name = 'Variant 2';

      final baseModel = ModelBase(
        unitName,
        tv: unitTV,
        roles: {Role.gp, Role.sk},
        movement: Movement([MovementType.walker], 6),
        armor: Armor(5),
        hullStructure: HullStructure(hull: 4, structure: 3),
        actions: UnitActions(2),
        gu: Skill(4),
        pi: Skill(5),
        ew: Skill(6),
        weapons: [],
        traits: [],
        height: 1.5,
      );

      final unit = Unit(
        baseModel,
        name: unitName,
        id: unitId,
        classification: unitClassification,
        subtype: unitSubtype,
        manufacturer: unitManufacturer,
        description: unitDescription,
        variants: [
          Variant(variant1Name, id: variant1Id, tv: 1, weapons: [], traits: []),
          Variant(variant2Name, id: variant2Id, tv: 2, weapons: [], traits: []),
        ],
      );

      expect(unit.name, unitName);
      expect(unit.id, unitId);
      expect(unit.classification, unitClassification);
      expect(unit.subtype, unitSubtype);
      expect(unit.manufacturer, unitManufacturer);
      expect(unit.description, unitDescription);
      expect(unit.variants.length, 2);
      expect(unit.variants[0].id, variant1Id);
      expect(unit.variants[0].name, variant1Name);
      expect(unit.variants[1].id, variant2Id);
      expect(unit.variants[1].name, variant2Name);
    });
  });
}
