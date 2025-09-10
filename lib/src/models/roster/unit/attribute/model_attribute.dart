import 'package:gearforce/src/models/roster/unit/attribute/role.dart';
import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/unit/attribute/armor.dart';
import 'package:gearforce/src/models/roster/unit/attribute/hull_structure.dart';
import 'package:gearforce/src/models/roster/unit/attribute/movement.dart';
import 'package:gearforce/src/models/roster/unit/attribute/skill.dart';
import 'package:gearforce/src/models/roster/unit/attribute/unit_actions.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_spec.dart';

enum ModelAttribute<T> {
  name<String>(),
  tv<int>(),
  roles<Set<Role>>(),
  movement<Movement>(),
  armor<Armor>(),
  hullStructure<HullStructure>(),
  actions<UnitActions>(),
  gu<Skill>(),
  pi<Skill>(),
  ew<Skill>(),
  weapons<List<WeaponSpec>>(),
  traits<List<Trait>>();

  const ModelAttribute();
}
