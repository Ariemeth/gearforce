import 'package:gearforce/versions/v4/domain/entities/unit/model.dart';
import 'package:gearforce/versions/v4/domain/entities/unit/model_upgrade.dart';

class ModelUpgradeContext {
  final Model model;
  ModelUpgrade upgrade;

  ModelUpgradeContext(this.model, this.upgrade);
}
