import 'package:meta/meta.dart';

import 'package:gearforce/src/models/roster/trait/trait_type.dart';

@immutable
class Trait {
  final String name;
  final String? description;
  final int? level;
  final TraitType? type;
  final bool isAux;

  const Trait({
    required this.name,
    this.description,
    this.level,
    this.type,
    this.isAux = false,
  });

  Trait copyWith({
    String? name,
    int? level,
    TraitType? type,
    bool? isAux,
  }) {
    return Trait(
      name: name ?? this.name,
      description: description,
      level: level ?? this.level,
      type: type ?? this.type,
      isAux: isAux ?? this.isAux,
    );
  }

  @override
  String toString() {
    final levelString = level != null ? ':$level' : '';
    final typeString = type != null ? ' ${type?.value}' : '';
    final auxString = isAux ? ' (Aux)' : '';
    return '$name$levelString$typeString$auxString';
  }
}
