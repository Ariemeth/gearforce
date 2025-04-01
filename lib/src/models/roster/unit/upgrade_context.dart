import 'package:gearforce/src/models/roster/unit/model.dart';
import 'package:gearforce/src/models/roster/unit/upgrade.dart';

class UpgradeContext {
  final Model model;
  Upgrade upgrade;

  UpgradeContext(this.model, this.upgrade);
}
