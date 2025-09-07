import 'package:flutter/foundation.dart';
import 'package:gearforce/src/models/roster/modifiers/common_modifiers.dart'
    show RequirementCheck, CommonModifiers;

@immutable
class Rule {
  final String name;
  final String id;
  final String description;
  final bool isEnabled;
  final bool canBeToggled;
  final RequirementCheck requirementCheck;

  const Rule({
    required this.name,
    required this.id,
    required this.description,
    this.isEnabled = true,
    this.canBeToggled = false,
    this.requirementCheck = CommonModifiers.defaultRequirementCheck,
  });

  Rule copyWith({
    String? name,
    String? id,
    String? description,
    bool? isEnabled,
    bool? canBeToggled,
    RequirementCheck? requirementCheck,
  }) {
    return Rule(
      name: name ?? this.name,
      id: id ?? this.id,
      description: description ?? this.description,
      isEnabled: isEnabled ?? this.isEnabled,
      canBeToggled: canBeToggled ?? this.canBeToggled,
      requirementCheck: requirementCheck ?? this.requirementCheck,
    );
  }
}
