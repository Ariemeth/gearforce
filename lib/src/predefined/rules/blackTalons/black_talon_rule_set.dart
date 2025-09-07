import 'package:gearforce/src/models/roster/rules/asset_table.dart';
import 'package:gearforce/src/models/roster/rules/rule_set.dart';
import 'package:gearforce/src/models/roster/unit/unit.dart';
import 'package:gearforce/src/predefined/units/blackTalons/units.dart';

class BlackTalonRuleSet extends RuleSet {
  const BlackTalonRuleSet()
    : super(
        name: 'Black Talon',
        rules: const [],
        assetTable: const AssetTable.unlimited(),
      );

  @override
  String toString() => 'BlackTalonRuleSet';

  @override
  List<Unit> getAvailableUnits() {
    return getBlackTalonUnits();
  }
}
