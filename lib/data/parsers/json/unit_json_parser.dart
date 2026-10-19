import 'package:gearforce/data/parsers/json/model_base_json_parser.dart';
import 'package:gearforce/data/parsers/json/model_upgrade_json_parser.dart';
import 'package:gearforce/data/parsers/json/variant_json_parser.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';

class UnitJsonParser {
  static Unit parseUnit(Map<String, dynamic> json) {
    // Flatten ModelBase fields if they are at the top level in JSON
    final Map<String, dynamic> baseJson;
    if (json.containsKey('base')) {
      baseJson = json['base'] as Map<String, dynamic>;
    } else {
      baseJson = Map<String, dynamic>.from(json);
      // Ensure hullStructure is present if hull/structure are top-level
      if (json.containsKey('hull') && json.containsKey('structure')) {
        baseJson['hullStructure'] = {
          'hull': json['hull'],
          'structure': json['structure'],
        };
      }
    }

    // Add unitId to baseJson (from Unit's id field)
    baseJson['unitId'] = json['id'];

    return Unit(
      ModelBaseJsonParser.parseModelBase(baseJson),
      id: json['id'] as String,
      variants: json['variants'] != null
          ? (json['variants'] as List)
                .map(
                  (e) =>
                      VariantJsonParser.parseVariant(e as Map<String, dynamic>),
                )
                .toList()
          : const [],
      availableProfileUpgrades: json['upgrades'] != null
          ? (json['upgrades'] as List)
                .map(
                  (e) => ModelUpgradeJsonParser.parseModelUpgrade(
                    e as Map<String, dynamic>,
                  ),
                )
                .toList()
          : const [],
    );
  }
}
