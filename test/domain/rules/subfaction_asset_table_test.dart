import 'package:flutter_test/flutter_test.dart';
import 'package:gearforce/domain/entities/faction/faction.dart';
import 'package:gearforce/domain/entities/faction/subfaction.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/repositories/unit_repository.dart';
import 'package:gearforce/domain/rules/factions/get_subfaction_rule_set.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/ng.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/nlc.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/umf.dart';
import 'package:gearforce/domain/rules/factions/north/subfactions/wp.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/ese.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/ha.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/md.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/milicia.dart';
import 'package:gearforce/domain/rules/factions/south/subfactions/sr.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/hscs.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/kad.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/nsdf.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/pak.dart';
import 'package:gearforce/domain/rules/factions/nucoal/subfactions/th.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/poc.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/pps.dart';
import 'package:gearforce/domain/rules/factions/peaceriver/subfactions/prdf.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tat.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tit.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/trt.dart';
import 'package:gearforce/domain/rules/factions/black_talons/subfactions/tst.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/eaz.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/ef.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/gf.dart';
import 'package:gearforce/domain/rules/factions/cef/subfactions/rf.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/cms.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/cs.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/hs.dart';
import 'package:gearforce/domain/rules/factions/caprice/subfactions/lm.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/ga.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/iap.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/is.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/isk.dart';
import 'package:gearforce/domain/rules/factions/utopia/subfactions/urs.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ahkc.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ak.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/mc.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/ns.dart';
import 'package:gearforce/domain/rules/factions/eden/subfactions/se.dart';

class _FakeUnitRepository implements UnitRepository {
  @override
  Future<List<Unit>> getUnitsByFaction(Faction faction) async => [];

  @override
  Future<Unit?> getUnitById(String unitId) async => null;
}

void main() {
  late UnitRepository unitRepository;

  setUp(() {
    unitRepository = _FakeUnitRepository();
  });

  group('Default faction subfactions keep unlimited asset table', () {
    const defaultSubfactions = [
      Subfaction.northDefault,
      Subfaction.southDefault,
      Subfaction.nuCoalDefault,
      Subfaction.peaceRiverDefault,
      Subfaction.talonDefault,
      Subfaction.cefDefault,
      Subfaction.capriceDefault,
      Subfaction.utopiaDefault,
      Subfaction.edenDefault,
      Subfaction.newJerusalemDefault,
    ];

    for (final subfaction in defaultSubfactions) {
      test('${subfaction.name} uses unlimited asset table', () {
        final ruleSet = getSubfactionRuleSet(subfaction, unitRepository);
        expect(ruleSet.assetTable.greenSquads, isNull);
        expect(ruleSet.assetTable.regularSquads, isNull);
        expect(ruleSet.assetTable.veteranSquads, isNull);
        expect(ruleSet.assetTable.eliteSquads, isNull);
        expect(ruleSet.assetTable.duelistOrAces, isNull);
        expect(ruleSet.assetTable.airSupport, isNull);
        expect(ruleSet.assetTable.artillerySupport, isNull);
        expect(ruleSet.assetTable.droneSupport, isNull);
      });
    }
  });

  group('Subfaction rule sets use AssetTable.one() by default', () {
    test('North subfactions use AssetTable.one()', () {
      final ng = NorthRuleSetNg(unitRepository);
      final wp = NorthRuleSetWp(unitRepository);
      final umf = NorthRuleSetUmf(unitRepository);
      final nlc = NorthRuleSetNlc(unitRepository);

      for (final ruleSet in [ng, wp, umf, nlc]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
        expect(ruleSet.assetTable.duelistOrAces, 1);
        expect(ruleSet.assetTable.airSupport, 1);
        expect(ruleSet.assetTable.artillerySupport, 1);
        expect(ruleSet.assetTable.droneSupport, 1);
      }
    });

    test('South subfactions use AssetTable.one()', () {
      final sr = SouthRuleSetSr(unitRepository);
      final milicia = SouthRuleSetMilicia(unitRepository);
      final md = SouthRuleSetMd(unitRepository);
      final ese = SouthRuleSetEse(unitRepository);
      final ha = SouthRuleSetHa(unitRepository);

      for (final ruleSet in [sr, milicia, md, ese, ha]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('NuCoal subfactions use AssetTable.one()', () {
      final nsdf = NuCoalRuleSetNsdf(unitRepository);
      final pak = NuCoalRuleSetPak(unitRepository);
      final kad = NuCoalRuleSetKad(unitRepository);
      final th = NuCoalRuleSetTh(unitRepository);
      final hscs = NuCoalRuleSetHscs(unitRepository);

      for (final ruleSet in [nsdf, pak, kad, th, hscs]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('Peace River subfactions use AssetTable.one()', () {
      final prdf = PeaceRiverRuleSetPrdf(unitRepository);
      final poc = PeaceRiverRuleSetPoc(unitRepository);
      final pps = PeaceRiverRuleSetPps(unitRepository);

      for (final ruleSet in [prdf, poc, pps]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('Black Talon subfactions use AssetTable.one()', () {
      final trt = BlackTalonRuleSetTrt(unitRepository);
      final tit = BlackTalonRuleSetTit(unitRepository);
      final tat = BlackTalonRuleSetTat(unitRepository);
      final tst = BlackTalonRuleSetTst(unitRepository);

      for (final ruleSet in [trt, tit, tat, tst]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('CEF subfactions use AssetTable.one()', () {
      final ef = CefRuleSetEf(unitRepository);
      final gf = CefRuleSetGf(unitRepository);
      final eaz = CefRuleSetEaz(unitRepository);
      final rf = CefRuleSetRf(unitRepository);

      for (final ruleSet in [ef, gf, eaz, rf]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('Caprice subfactions use AssetTable.one()', () {
      final hs = CapriceRuleSetHs(unitRepository);
      final cms = CapriceRuleSetCms(unitRepository);
      final cs = CapriceRuleSetCs(unitRepository);
      final lm = CapriceRuleSetLm(unitRepository);

      for (final ruleSet in [hs, cms, cs, lm]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('Utopia subfactions use AssetTable.one()', () {
      final urs = UtopiaRuleSetUrs(unitRepository);
      final isk = UtopiaRuleSetIsk(unitRepository);
      final ga = UtopiaRuleSetGa(unitRepository);
      final isSub = UtopiaRuleSetIs(unitRepository);
      final iap = UtopiaRuleSetIap(unitRepository);

      for (final ruleSet in [urs, isk, ga, isSub, iap]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test('Eden subfactions use AssetTable.one()', () {
      final se = EdenRuleSetSe(unitRepository);
      final ak = EdenRuleSetAk(unitRepository);
      final mc = EdenRuleSetMc(unitRepository);
      final ns = EdenRuleSetNs(unitRepository);
      final ahkc = EdenRuleSetAhkc(unitRepository);

      for (final ruleSet in [se, ak, mc, ns, ahkc]) {
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.regularSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
        expect(ruleSet.assetTable.eliteSquads, 1);
      }
    });

    test(
      'getSubfactionRuleSet returns subfaction rule set with AssetTable.one()',
      () {
        final ruleSet = getSubfactionRuleSet(
          Subfaction.norguard,
          unitRepository,
        );
        expect(ruleSet.assetTable.greenSquads, 1);
        expect(ruleSet.assetTable.veteranSquads, 1);
      },
    );
  });
}
