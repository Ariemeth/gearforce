import 'package:gearforce/src/pages/roster/models/role.dart';
import 'package:gearforce/src/pages/roster/models/trait/trait.dart';
import 'package:gearforce/src/pages/roster/models/unit/armor.dart';
import 'package:gearforce/src/pages/roster/models/unit/hull_structure.dart';
import 'package:gearforce/src/pages/roster/models/unit/movement.dart';
import 'package:gearforce/src/pages/roster/models/unit/skill.dart';
import 'package:gearforce/src/pages/roster/models/unit/unit_actions.dart';
import 'package:gearforce/src/pages/roster/models/weapon/weapon.dart';

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
  weapons<List<Weapon>>(),
  traits<List<Trait>>();

  const ModelAttribute();
}
