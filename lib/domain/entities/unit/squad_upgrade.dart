import 'package:gearforce/domain/entities/attribute/classification.dart';
import 'package:meta/meta.dart';

enum SquadUpgradeColumn { mounted, react }

@immutable
class SquadUpgrade {
  final String id;
  final String name;
  final int tv;
  final String description;
  final String weaponCode;
  final SquadUpgradeColumn column;
  final Set<Classification> allowedClassifications;

  const SquadUpgrade({
    required this.id,
    required this.name,
    required this.tv,
    required this.description,
    required this.weaponCode,
    required this.column,
    this.allowedClassifications = const {Classification.gear},
  });

  bool canApplyToClassification(Classification classification) {
    return allowedClassifications.contains(classification);
  }
}