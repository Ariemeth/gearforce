import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement_type.dart';
import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/unit/unit_base.dart';

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

      final unitBase = UnitBase(
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
      );

      expect(unitBase.name, unitName);
      expect(unitBase.tv, tv);
      expect(unitBase.roles, roles);
      expect(unitBase.movement.value, movement.value);
      expect(unitBase.armor.value, armor.value);
      expect(unitBase.hullStructure.hull, hullStructure.hull);
      expect(unitBase.hullStructure.structure, hullStructure.structure);
      expect(unitBase.actions.value, actions.value);
      expect(unitBase.gu.value, gu.value);
      expect(unitBase.pi.value, pi.value);
      expect(unitBase.ew.value, ew.value);
      expect(unitBase.height, height);
    });
  });
}
