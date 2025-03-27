import 'package:meta/meta.dart';

import 'package:gearforce/src/pages/roster/models/trait_factory.dart';
import 'package:gearforce/src/pages/roster/models/trait_type.dart';

// regular expression to match against a traits level and type
final RegExp _levelAndTypeRegex = RegExp(r':(\d+)(?:\s+(\w+))?$');

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

  static TraitType? _parseTraitType(String? typeString) {
    if (typeString == null) return null;
    return TraitType.values.firstWhere(
      (t) => t.value.toLowerCase() == typeString.toLowerCase(),
      orElse: () => throw ArgumentError('Unknown trait type: $typeString'),
    );
  }

  factory Trait.fromName(String name) {
    final isAux = name.toLowerCase().contains('(aux)');
    final levelAndTypeMatch = _levelAndTypeRegex.firstMatch(name);
    final level = levelAndTypeMatch != null
        ? int.parse(levelAndTypeMatch.group(1)!)
        : null;
    final typeString = levelAndTypeMatch?.group(2);
    final type = _parseTraitType(typeString);
    final cleanName = name
        .replaceAll(RegExp(r'\s*\(aux\)', caseSensitive: false), '')
        .replaceAll(_levelAndTypeRegex, '')
        .trim();

    switch (cleanName.toLowerCase()) {
      case 'agile':
        return TraitFactory.agile(isAux: isAux);
      case 'hands':
        return TraitFactory.hands(isAux: isAux);
      case 'aa':
        return TraitFactory.aa(isAux: isAux);
      case 'ap':
        return TraitFactory.ap(isAux: isAux, level: level);
      case 'ai':
        return TraitFactory.ai(isAux: isAux);
      case 'airdrop':
        return TraitFactory.airdrop(isAux: isAux);
      case 'amphib':
        return TraitFactory.amphib(isAux: isAux);
      case 'ams':
        return TraitFactory.ams(isAux: isAux);
      case 'aoe':
        return TraitFactory.aoe(isAux: isAux, level: level);
      case 'apex':
        return TraitFactory.apex(isAux: isAux);
      case 'auto':
        return TraitFactory.auto(isAux: isAux);
      case 'aux':
        return TraitFactory.aux(isAux: isAux);
      case 'b':
        return TraitFactory.b(isAux: isAux);
      case 'blast':
        return TraitFactory.blast(isAux: isAux);
      case 'brawl':
        return TraitFactory.brawl(isAux: isAux, level: level);
      case 'burst':
        return TraitFactory.burst(isAux: isAux, level: level);
      case 'climb':
        return TraitFactory.climb(isAux: isAux);
      case 'corrosion':
        return TraitFactory.corrosion(isAux: isAux);
      case 'demo':
        return TraitFactory.demo(isAux: isAux, level: level);
      case 'e-comms':
        return TraitFactory.eComms(isAux: isAux);
      case 'ecm':
        return TraitFactory.ecm(isAux: isAux);
      case 'ecm+':
        return TraitFactory.ecmPlus(isAux: isAux);
      case 'eccm':
        return TraitFactory.eccm(isAux: isAux);
      case 'eccm+':
        return TraitFactory.eccmPlus(isAux: isAux);
      case 'fire':
        return TraitFactory.fire(isAux: isAux, level: level);
      case 'frag':
        return TraitFactory.frag(isAux: isAux);
      case 'guided':
        return TraitFactory.guided(isAux: isAux);
      case 'haywire':
        return TraitFactory.haywire(isAux: isAux);
      case 'hi-tech':
        return TraitFactory.hiTech(isAux: isAux);
      case 'init+':
        return TraitFactory.initPlus(isAux: isAux);
      case 'jetpack':
        return TraitFactory.jetpack(isAux: isAux, level: level);
      case 'jump':
        return TraitFactory.jump(isAux: isAux, level: level);
      case 'la':
        return TraitFactory.la(isAux: isAux, level: level);
      case 'linked':
        return TraitFactory.linked(isAux: isAux);
      case 'lo-tech':
        return TraitFactory.loTech(isAux: isAux);
      case 'lumbering':
        return TraitFactory.lumbering(isAux: isAux);
      case 'medic':
        return TraitFactory.medic(isAux: isAux, level: level);
      case 'occupancy':
        if (type == null) {
          throw ArgumentError('Trait.occupancy requires a non-null type.');
        }
        return TraitFactory.occupancy(isAux: isAux, level: level, type: type);
      case 'offroad':
        return TraitFactory.offroad(isAux: isAux);
      case 'open top':
        return TraitFactory.openTop(isAux: isAux);
      case 'precise':
        return TraitFactory.precise(isAux: isAux);
      case 'precise+':
        return TraitFactory.precisePlus(isAux: isAux);
      case 'proximity':
        return TraitFactory.proximity(isAux: isAux);
      case 'r':
        return TraitFactory.r(isAux: isAux);
      case 'reach':
        return TraitFactory.reach(isAux: isAux, level: level);
      case 'react':
        return TraitFactory.react(isAux: isAux);
      case 'react+':
        return TraitFactory.reactPlus(isAux: isAux);
      case 'reflex':
        return TraitFactory.reflex(isAux: isAux);
      case 'repair':
        return TraitFactory.repair(isAux: isAux, level: level);
      case 'resist':
        return TraitFactory.resist(isAux: isAux, type: type);
      case 'satup':
        return TraitFactory.satUp(isAux: isAux);
      case 'sensor boom':
        return TraitFactory.sensorBoom(isAux: isAux);
      case 'sensor':
        return TraitFactory.sensor(isAux: isAux, level: level);
      case 'shield':
        return TraitFactory.shield(isAux: isAux);
      case 'silent':
        return TraitFactory.silent(isAux: isAux);
      case 'smoke':
        return TraitFactory.smoke(isAux: isAux);
      case 'sp':
        return TraitFactory.sp1(isAux: isAux);
      case 'spray':
        return TraitFactory.spray(isAux: isAux);
      case 'stable':
        return TraitFactory.stable(isAux: isAux);
      case 'stationary':
        return TraitFactory.stationary(isAux: isAux);
      case 'stealth':
        return TraitFactory.stealth(isAux: isAux);
      case 'sub':
        return TraitFactory.sub(isAux: isAux);
      case 'supply':
        return TraitFactory.supply(isAux: isAux);
      case 'td':
        return TraitFactory.td(isAux: isAux);
      case 'towed':
        return TraitFactory.towed(isAux: isAux);
      case 'transport':
        if (type == null) {
          throw ArgumentError('Trait.transport requires a non-null type.');
        }
        return TraitFactory.transport(isAux: isAux, level: level, type: type);
      case 't':
        return TraitFactory.t(isAux: isAux);
      case 'vtol':
        return TraitFactory.vtol(isAux: isAux);
      case 'vuln':
        if (type == null) {
          throw ArgumentError('Trait.vuln requires a non-null type.');
        }
        return TraitFactory.vuln(isAux: isAux, type: type);
      default:
        throw ArgumentError('Unknown trait name: $cleanName');
    }
  }

  Trait copyWith({
    String? name,
    int? level,
    TraitType? type,
    bool? isAux,
  }) {
    return Trait(
      name: name ?? this.name,
      description: description, // Prevent changes to description
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
