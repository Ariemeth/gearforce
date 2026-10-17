import 'package:gearforce/data/static/catalogs/trait_catalog.dart';
import 'package:gearforce/domain/entities/equipment/trait.dart';
import 'package:gearforce/domain/entities/equipment/trait_type.dart';

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

  static String? _getTypeFromSuffix(String name) {
    final match = RegExp(r':([a-zA-Z])$').firstMatch(name);
    return match?.group(1);
  }

  static Trait traitFromString(String name) {
    final isAux = name.toLowerCase().contains('(aux)');
    final levelAndTypeMatch = _levelAndTypeRegex.firstMatch(name);
    final level = levelAndTypeMatch != null
        ? int.tryParse(levelAndTypeMatch.group(1)!)
        : null;
    final typeString =
        levelAndTypeMatch?.group(2) ??
        (levelAndTypeMatch == null ? _getTypeFromSuffix(name) : null);
    final type = _parseTraitType(typeString);
    final cleanName = name
        .replaceAll(RegExp(r'\s*\(aux\)', caseSensitive: false), '')
        .replaceAll(_levelAndTypeRegex, '')
        .replaceFirst(RegExp(r':[a-zA-Z]$'), '')
        .trim();

    switch (cleanName.toLowerCase()) {
      case 'agile':
        return TraitCatalog.agile(isAux: isAux);
      case 'aa':
        return TraitCatalog.aa(isAux: isAux);
      case 'ap':
        return TraitCatalog.ap(isAux: isAux, level: level ?? 0);
      case 'ai':
        return TraitCatalog.ai(isAux: isAux);
      case 'airdrop':
        return TraitCatalog.airdrop(isAux: isAux);
      case 'amphib':
        return TraitCatalog.amphib(isAux: isAux);
      case 'ams':
        return TraitCatalog.ams(isAux: isAux);
      case 'aoe':
        return TraitCatalog.aoe(isAux: isAux, level: level);
      case 'apex':
        return TraitCatalog.apex(isAux: isAux);
      case 'auto':
        return TraitCatalog.auto(isAux: isAux);
      case 'aux':
        return TraitCatalog.aux(isAux: isAux);
      case 'b':
        return TraitCatalog.b(isAux: isAux);
      case 'blast':
        return TraitCatalog.blast(isAux: isAux);
      case 'brawl':
        return TraitCatalog.brawl(isAux: isAux, level: level);
      case 'burst':
        return TraitCatalog.burst(isAux: isAux, level: level);
      case 'climb':
        return TraitCatalog.climb(isAux: isAux);
      case 'corrosion':
        return TraitCatalog.corrosion(isAux: isAux);
      case 'demo':
        return TraitCatalog.demo(isAux: isAux, level: level);
      case 'e-comms':
        return TraitCatalog.eComms(isAux: isAux);
      case 'ecm':
        return TraitCatalog.ecm(isAux: isAux);
      case 'ecm+':
        return TraitCatalog.ecmPlus(isAux: isAux);
      case 'eccm':
        return TraitCatalog.eccm(isAux: isAux);
      case 'eccm+':
        return TraitCatalog.eccmPlus(isAux: isAux);
      case 'fire':
        return TraitCatalog.fire(isAux: isAux, level: level);
      case 'frag':
        return TraitCatalog.frag(isAux: isAux);
      case 'green':
        return TraitCatalog.green();
      case 'guided':
        return TraitCatalog.guided(isAux: isAux);
      case 'hands':
        return TraitCatalog.hands(isAux: isAux);
      case 'haywire':
        return TraitCatalog.haywire(isAux: isAux);
      case 'hi-tech':
        return TraitCatalog.hiTech(isAux: isAux);
      case 'immobilize':
        return TraitCatalog.immobilize(isAux: isAux);
      case 'init+':
        return TraitCatalog.initPlus(isAux: isAux);
      case 'jetpack':
        return TraitCatalog.jetpack(isAux: isAux, level: level);
      case 'jump':
        return TraitCatalog.jump(isAux: isAux, level: level);
      case 'la':
        return TraitCatalog.la(isAux: isAux, level: level);
      case 'linked':
        return TraitCatalog.linked(isAux: isAux);
      case 'lo-tech':
        return TraitCatalog.loTech(isAux: isAux);
      case 'lumbering':
        return TraitCatalog.lumbering(isAux: isAux);
      case 'medic':
        return TraitCatalog.medic(isAux: isAux, level: level);
      case 'occupancy':
        if (type == null) {
          throw ArgumentError('Trait.occupancy requires a non-null type.');
        }
        return TraitCatalog.occupancy(isAux: isAux, level: level, type: type);
      case 'offroad':
        return TraitCatalog.offroad(isAux: isAux);
      case 'open top':
        return TraitCatalog.openTop(isAux: isAux);
      case 'precise':
        return TraitCatalog.precise(isAux: isAux);
      case 'precise+':
        return TraitCatalog.precisePlus(isAux: isAux);
      case 'proximity':
        return TraitCatalog.proximity(isAux: isAux);
      case 'r':
        return TraitCatalog.r(isAux: isAux);
      case 'reach':
        return TraitCatalog.reach(isAux: isAux, level: level);
      case 'react':
        return TraitCatalog.react(isAux: isAux);
      case 'react+':
        return TraitCatalog.reactPlus(isAux: isAux);
      case 'reflex':
        return TraitCatalog.reflex(isAux: isAux);
      case 'repair':
        return TraitCatalog.repair(isAux: isAux, level: level);
      case 'resist':
        return TraitCatalog.resist(isAux: isAux, type: type);
      case 'satup':
        return TraitCatalog.satUp(isAux: isAux);
      case 'sensor boom':
        return TraitCatalog.sensorBoom(isAux: isAux);
      case 'sensor':
        return TraitCatalog.sensor(isAux: isAux, level: level);
      case 'shield':
        return TraitCatalog.shield(isAux: isAux);
      case 'silent':
        return TraitCatalog.silent(isAux: isAux);
      case 'smoke':
        return TraitCatalog.smoke(isAux: isAux);
      case 'sp':
        return TraitCatalog.sp1(isAux: isAux);
      case 'spray':
        return TraitCatalog.spray(isAux: isAux);
      case 'stable':
        return TraitCatalog.stable(isAux: isAux);
      case 'stationary':
        return TraitCatalog.stationary(isAux: isAux);
      case 'stealth':
        return TraitCatalog.stealth(isAux: isAux);
      case 'sub':
        return TraitCatalog.sub(isAux: isAux);
      case 'supply':
        return TraitCatalog.supply(isAux: isAux);
      case 'td':
        return TraitCatalog.td(isAux: isAux);
      case 'towed':
        return TraitCatalog.towed(isAux: isAux);
      case 'transport':
        if (type == null) {
          throw ArgumentError('Trait.transport requires a non-null type.');
        }
        return TraitCatalog.transport(isAux: isAux, level: level, type: type);
      case 't':
        return TraitCatalog.t(isAux: isAux);
      case 'vtol':
        return TraitCatalog.vtol(isAux: isAux);
      case 'vuln':
        if (type == null) {
          throw ArgumentError('Trait.vuln requires a non-null type.');
        }
        return TraitCatalog.vuln(isAux: isAux, type: type);
      default:
        throw ArgumentError('Unknown trait name: $cleanName');
    }
  }
}
