import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/model_attribute.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/movement_type.dart';
import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/model_base.dart';
import 'package:gearforce/domain/entities/unit/model_upgrade.dart';
import 'package:gearforce/domain/entities/unit/upgrade_type.dart';
import 'package:gearforce/domain/entities/unit/variant.dart';

void main() {
  group('Model getAttribute', () {
    test('should retrieve attribute without mods', () {
      // Arrange
      final model = Model(
        id: 0,
        base: ModelBase(
          'Test Model',
          unitId: 'test-unit',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          height: 1.5,
          classification: Classification.gear,
        ),
        variant: Variant('Test Model', id: '1', tv: 0),
      );

      // Act & Assert
      expect(model.getAttribute(ModelAttribute.name), 'Test Model');
      expect(model.getAttribute(ModelAttribute.tv), 10);
      expect(model.getAttribute(ModelAttribute.roles), {Role.gp});
      expect(model.getAttribute(ModelAttribute.movement).value, 6);
      expect(model.getAttribute(ModelAttribute.armor).value, 5);
    });

    test('should retrieve attribute with mods applied', () {
      // Arrange
      final model = Model(
        id: 0,
        base: ModelBase(
          'Test Model',
          unitId: 'test-unit',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          height: 1.5,
          classification: Classification.gear,
        ),
        variant: Variant('Test Model', id: '1', tv: 0),
        selectedModelUpgrades: [
          ModelUpgrade(
            'Test Mod',
            id: 'mod-001',
            type: UpgradeType.unit,
            nameMod: (name, context) => 'Modified $name',
            tvMod: (tv, context) => tv + 5,
            rolesMod: (roles, context) => {...roles, Role.sk},
            movementMod: (movement, context) =>
                Movement([MovementType.ground], 8),
            armorMod: (armor, context) => Armor(6),
          ),
        ],
      );

      // Act & Assert
      expect(model.getAttribute(ModelAttribute.name), 'Modified Test Model');
      expect(model.getAttribute(ModelAttribute.tv), 15);
      expect(model.getAttribute(ModelAttribute.roles), {Role.gp, Role.sk});
      expect(model.getAttribute(ModelAttribute.movement).value, 8);
      expect(model.getAttribute(ModelAttribute.armor).value, 6);
    });

    test('should retrieve attribute excluding a specific mod', () {
      // Arrange
      var model = Model(
        id: 0,
        base: ModelBase(
          'Test Model',
          unitId: 'test-unit',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          height: 1.5,
          classification: Classification.gear,
        ),
        variant: Variant('Test Model', id: '1', tv: 0),
        selectedModelUpgrades: [
          ModelUpgrade(
            'Mod 1',
            id: 'mod-001',
            type: UpgradeType.unit,
            tvMod: (tv, context) => tv + 5,
          ),
          ModelUpgrade(
            'Mod 2',
            id: 'mod-002',
            type: UpgradeType.unit,
            tvMod: (tv, context) => tv + 3,
          ),
        ],
      );

      // Act & Assert
      expect(
        model.getAttribute(ModelAttribute.tv),
        18,
        reason: 'Both mods applied',
      ); // Both mods applied
      expect(
        model.getAttribute(ModelAttribute.tv, excludeUpgradeId: 'mod-001'),
        13,
        reason: 'Only Mod 2 applied',
      );
      expect(
        model.getAttribute(ModelAttribute.tv, excludeUpgradeId: 'mod-002'),
        15,
        reason: 'Only Mod 1 applied',
      );
    });

    test('should retrieve attribute applying mods up to a specific mod', () {
      // Arrange
      final model = Model(
        id: 0,
        base: ModelBase(
          'Test Model',
          unitId: 'test-unit',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          height: 1.5,
          classification: Classification.gear,
        ),
        variant: Variant('Test Model', id: '1', tv: 0),
        selectedModelUpgrades: [
          ModelUpgrade(
            'Mod 1',
            id: 'mod-001',
            type: UpgradeType.unit,
            tvMod: (tv, context) => tv + 5,
          ),
          ModelUpgrade(
            'Mod 2',
            id: 'mod-002',
            type: UpgradeType.unit,
            tvMod: (tv, context) => tv + 3,
          ),
        ],
      );

      // Act & Assert
      expect(
        model.getAttribute(ModelAttribute.tv, upToUpgradeId: 'mod-001'),
        15,
        reason: 'Only Mod 1 applied',
      );
      expect(
        model.getAttribute(ModelAttribute.tv, upToUpgradeId: 'mod-002'),
        18,
        reason: 'Both mods applied',
      );
    });
  });
  group('Model getAttribute Recursive Detection', () {
    test('should throw StateError on recursive getAttribute calls', () {
      // Arrange
      final model = Model(
        id: 0,
        base: ModelBase(
          'Test Model',
          unitId: 'test-unit',
          tv: 10,
          roles: {Role.gp},
          movement: Movement([MovementType.walker], 6),
          armor: Armor(5),
          hullStructure: HullStructure(hull: 4, structure: 3),
          actions: UnitActions(2),
          gu: Skill(4),
          pi: Skill(5),
          ew: Skill(6),
          mountedWeapons: [],
          traits: [],
          height: 1.5,
          classification: Classification.gear,
        ),
        variant: Variant('Test Model', id: '1', tv: 0),
        selectedModelUpgrades: [],
      );

      final modelWithUpgrade = model.addModelUpgrade(
        ModelUpgrade(
          'Test Mod',
          id: 'mod-001',
          type: UpgradeType.unit,
          nameMod: (name, context) => 'Modified ${context.model.name}',
        ),
      );

      // Act & Assert
      expect(
        () {
          // Simulate a recursive call by calling getAttribute for the same attribute
          modelWithUpgrade.getAttribute(
            ModelAttribute.name,
            excludeUpgradeId: 'test',
          );
          modelWithUpgrade.getAttribute(
            ModelAttribute.name,
            excludeUpgradeId: 'test',
          );
        },
        throwsA(
          isA<StateError>().having(
            (e) => e.message,
            'message',
            contains('Recursive call detected for getAttribute'),
          ),
        ),
      );
    });
  });
}
