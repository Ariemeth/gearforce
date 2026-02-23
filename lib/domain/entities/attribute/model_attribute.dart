import 'package:gearforce/domain/entities/attribute/role.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/attribute/armor.dart';
import 'package:gearforce/domain/entities/attribute/hull_structure.dart';
import 'package:gearforce/domain/entities/attribute/movement.dart';
import 'package:gearforce/domain/entities/attribute/skill.dart';
import 'package:gearforce/domain/entities/attribute/unit_actions.dart';
import 'package:gearforce/domain/entities/equipment/weapon_spec.dart';

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
