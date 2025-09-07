import 'package:gearforce/src/models/roster/modifiers/common_modifiers.dart'
    show RequirementCheck, CommonModifiers;

class Rule {
  final String name;
  final String id;
  final String description;
  bool isEnabled;
  bool canBeToggled;
  RequirementCheck requirementCheck;

  Rule({
    required this.name,
    required this.id,
    required this.description,
    this.isEnabled = true,
    this.canBeToggled = false,
    this.requirementCheck = CommonModifiers.defaultRequirementCheck,
  });
}
