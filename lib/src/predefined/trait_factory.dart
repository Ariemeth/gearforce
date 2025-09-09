import 'package:gearforce/src/models/roster/trait/trait.dart';
import 'package:gearforce/src/models/roster/trait/trait_type.dart';

// regular expression to match against a traits level and type
final RegExp _levelAndTypeRegex = RegExp(r':(\d+)(?:\s+(\w+))?$');

class TraitFactory {
  static TraitType? _parseTraitType(String? typeString) {
    if (typeString == null) return null;
    return TraitType.values.firstWhere(
      (t) => t.value.toLowerCase() == typeString.toLowerCase(),
      orElse: () => throw ArgumentError('Unknown trait type: $typeString'),
    );
  }

  static Trait traitFromString(String name) {
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
        return Trait.agile(isAux: isAux);
      case 'aa':
        return Trait.aa(isAux: isAux);
      case 'ap':
        return Trait.ap(isAux: isAux, level: level!);
      case 'ai':
        return Trait.ai(isAux: isAux);
      case 'airdrop':
        return Trait.airdrop(isAux: isAux);
      case 'amphib':
        return Trait.amphib(isAux: isAux);
      case 'ams':
        return Trait.ams(isAux: isAux);
      case 'aoe':
        return Trait.aoe(isAux: isAux, level: level);
      case 'apex':
        return Trait.apex(isAux: isAux);
      case 'auto':
        return Trait.auto(isAux: isAux);
      case 'aux':
        return Trait.aux(isAux: isAux);
      case 'b':
        return Trait.b(isAux: isAux);
      case 'blast':
        return Trait.blast(isAux: isAux);
      case 'brawl':
        return Trait.brawl(isAux: isAux, level: level);
      case 'burst':
        return Trait.burst(isAux: isAux, level: level);
      case 'climb':
        return Trait.climb(isAux: isAux);
      case 'corrosion':
        return Trait.corrosion(isAux: isAux);
      case 'demo':
        return Trait.demo(isAux: isAux, level: level);
      case 'e-comms':
        return Trait.eComms(isAux: isAux);
      case 'ecm':
        return Trait.ecm(isAux: isAux);
      case 'ecm+':
        return Trait.ecmPlus(isAux: isAux);
      case 'eccm':
        return Trait.eccm(isAux: isAux);
      case 'eccm+':
        return Trait.eccmPlus(isAux: isAux);
      case 'fire':
        return Trait.fire(isAux: isAux, level: level);
      case 'frag':
        return Trait.frag(isAux: isAux);
      case 'green':
        return Trait.green();
      case 'guided':
        return Trait.guided(isAux: isAux);
      case 'hands':
        return Trait.hands(isAux: isAux);
      case 'haywire':
        return Trait.haywire(isAux: isAux);
      case 'hi-tech':
        return Trait.hiTech(isAux: isAux);
      case 'immobilize':
        return Trait.immobilize(isAux: isAux);
      case 'init+':
        return Trait.initPlus(isAux: isAux);
      case 'jetpack':
        return Trait.jetpack(isAux: isAux, level: level);
      case 'jump':
        return Trait.jump(isAux: isAux, level: level);
      case 'la':
        return Trait.la(isAux: isAux, level: level);
      case 'linked':
        return Trait.linked(isAux: isAux);
      case 'lo-tech':
        return Trait.loTech(isAux: isAux);
      case 'lumbering':
        return Trait.lumbering(isAux: isAux);
      case 'medic':
        return Trait.medic(isAux: isAux, level: level);
      case 'occupancy':
        if (type == null) {
          throw ArgumentError('Trait.occupancy requires a non-null type.');
        }
        return Trait.occupancy(isAux: isAux, level: level, type: type);
      case 'offroad':
        return Trait.offroad(isAux: isAux);
      case 'open top':
        return Trait.openTop(isAux: isAux);
      case 'precise':
        return Trait.precise(isAux: isAux);
      case 'precise+':
        return Trait.precisePlus(isAux: isAux);
      case 'proximity':
        return Trait.proximity(isAux: isAux);
      case 'r':
        return Trait.r(isAux: isAux);
      case 'reach':
        return Trait.reach(isAux: isAux, level: level);
      case 'react':
        return Trait.react(isAux: isAux);
      case 'react+':
        return Trait.reactPlus(isAux: isAux);
      case 'reflex':
        return Trait.reflex(isAux: isAux);
      case 'repair':
        return Trait.repair(isAux: isAux, level: level);
      case 'resist':
        return Trait.resist(isAux: isAux, type: type);
      case 'satup':
        return Trait.satUp(isAux: isAux);
      case 'sensor boom':
        return Trait.sensorBoom(isAux: isAux);
      case 'sensor':
        return Trait.sensor(isAux: isAux, level: level);
      case 'shield':
        return Trait.shield(isAux: isAux);
      case 'silent':
        return Trait.silent(isAux: isAux);
      case 'smoke':
        return Trait.smoke(isAux: isAux);
      case 'sp':
        return Trait.sp1(isAux: isAux);
      case 'spray':
        return Trait.spray(isAux: isAux);
      case 'stable':
        return Trait.stable(isAux: isAux);
      case 'stationary':
        return Trait.stationary(isAux: isAux);
      case 'stealth':
        return Trait.stealth(isAux: isAux);
      case 'sub':
        return Trait.sub(isAux: isAux);
      case 'supply':
        return Trait.supply(isAux: isAux);
      case 'td':
        return Trait.td(isAux: isAux);
      case 'towed':
        return Trait.towed(isAux: isAux);
      case 'transport':
        if (type == null) {
          throw ArgumentError('Trait.transport requires a non-null type.');
        }
        return Trait.transport(isAux: isAux, level: level, type: type);
      case 't':
        return Trait.t(isAux: isAux);
      case 'vtol':
        return Trait.vtol(isAux: isAux);
      case 'vuln':
        if (type == null) {
          throw ArgumentError('Trait.vuln requires a non-null type.');
        }
        return Trait.vuln(isAux: isAux, type: type);
      default:
        throw ArgumentError('Unknown trait name: $cleanName');
    }
  }
}
