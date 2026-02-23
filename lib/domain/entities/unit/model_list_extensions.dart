import 'package:gearforce/domain/entities/unit/model.dart';

extension ModelListExtensions on List<Model> {
  /// Get the sum of tv from all Models
  int get tv => fold(0, (sum, m) => sum + m.tv);
}
