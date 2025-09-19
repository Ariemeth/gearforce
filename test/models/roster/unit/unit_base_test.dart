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

void main() {
  group('UnitBase', () {
    test('should create UnitBase with correct properties', () {
      const unitName = 'Test Unit';
      const tv = 10;
      final roles = {Role.gp, Role.sk};
      final movement = Movement([MovementType.walker], 6);
      const armor = Armor(5);
      const hullStructure = HullStructure(hull: 4, structure: 3);
      const actions = UnitActions(2);
      const gu = Skill(4);
      const pi = Skill(5);
      const ew = Skill(6);
      const height = 1.5;

      final baseModel = ModelBase(
        unitName,
        tv: tv,
        roles: roles,
        movement: movement,
        armor: armor,
        hullStructure: hullStructure,
        actions: actions,
        gu: gu,
        pi: pi,
        ew: ew,
        weapons: [],
        traits: [],
        height: height,
        subtype: '',
        classification: Classification.gear,
      );

      expect(baseModel.name, unitName);
      expect(baseModel.tv, tv);
      expect(baseModel.roles, roles);
      expect(baseModel.movement.value, movement.value);
      expect(baseModel.armor.value, armor.value);
      expect(baseModel.hullStructure.hull, hullStructure.hull);
      expect(baseModel.hullStructure.structure, hullStructure.structure);
      expect(baseModel.actions.value, actions.value);
      expect(baseModel.gu.value, gu.value);
      expect(baseModel.pi.value, pi.value);
      expect(baseModel.ew.value, ew.value);
      expect(baseModel.height, height);
    });
  });
}
