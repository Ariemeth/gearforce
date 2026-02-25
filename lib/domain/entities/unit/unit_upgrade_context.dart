import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/unit_upgrade.dart';

class UnitUpgradeContext {
  final Model model;
  UnitUpgrade upgrade;

  UnitUpgradeContext(this.model, this.upgrade);
}
