import 'package:gearforce/src/models/roster/weapon/weapon.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart';

class WeaponFactory {
  static Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final size = WeaponSize.fromCode(code);
    switch (code.substring(1)) {
      case 'AAM':
        return Weapon.aam(size, hasReact: hasReact);
      case 'AC':
        return Weapon.ac(size, hasReact: hasReact);
      case 'AG':
        return Weapon.ag(size, hasReact: hasReact);
      case 'AM':
        return Weapon.am(size, hasReact: hasReact);
      case 'APGL':
        return Weapon.apgl(size, hasReact: hasReact);
      case 'AR':
        return Weapon.ar(size, hasReact: hasReact);
      case 'ATM':
        return switch (size) {
          WeaponSize.light => Weapon.atmLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.atmMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.atmHeavy(hasReact: hasReact),
        };
      case 'Bomb':
        return Weapon.bomb(size, hasReact: hasReact);
      case 'Napalm':
        return switch (size) {
          WeaponSize.light => Weapon.napalmLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.napalmMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.napalmHeavy(hasReact: hasReact),
        };
      case 'BZ':
        return switch (size) {
          WeaponSize.light => Weapon.bzLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.bzMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.bzHeavy(hasReact: hasReact),
        };
      case 'RBZ':
        return switch (size) {
          WeaponSize.light => Weapon.rbzLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.rbzMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.rbzHeavy(hasReact: hasReact),
        };
      case 'FC':
        return switch (size) {
          WeaponSize.light => Weapon.fcLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.fcMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.fcHeavy(hasReact: hasReact),
        };
      case 'FG':
        return switch (size) {
          WeaponSize.light => Weapon.fgLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.fgMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.fgHeavy(hasReact: hasReact),
        };
      case 'FL':
        return switch (size) {
          WeaponSize.light => Weapon.flLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.flMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.flHeavy(hasReact: hasReact),
        };
      case 'GG':
        return switch (size) {
          WeaponSize.light => Weapon.ggLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.ggMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.ggHeavy(hasReact: hasReact),
        };
      case 'GL':
        return switch (size) {
          WeaponSize.light => Weapon.glLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.glMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.glHeavy(hasReact: hasReact),
        };
      case 'HG':
        return switch (size) {
          WeaponSize.light => Weapon.hgLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.hgMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.hgHeavy(hasReact: hasReact),
        };
      case 'IATM':
        return switch (size) {
          WeaponSize.light => Weapon.iatmLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.iatmMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.iatmHeavy(hasReact: hasReact),
        };
      case 'IGL':
        return switch (size) {
          WeaponSize.light => Weapon.iglLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.iglMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.iglHeavy(hasReact: hasReact),
        };
      case 'ILW':
        return Weapon.ilw(size, hasReact: hasReact);
      case 'ILSR':
        return Weapon.ilsr(size, hasReact: hasReact);
      case 'IM':
        return Weapon.im(size, hasReact: hasReact);
      case 'IMG':
        return Weapon.img(size, hasReact: hasReact);
      case 'IMW':
        return Weapon.imw(size, hasReact: hasReact);
      case 'IR':
        return Weapon.ir(size, hasReact: hasReact);
      case 'IS':
        return Weapon.infs(size, hasReact: hasReact);
      case 'IW':
        return Weapon.iw(size, hasReact: hasReact);
      case 'LC':
        return Weapon.lc(size, hasReact: hasReact);
      case 'Mine':
        return Weapon.mine(size, hasReact: hasReact);
      case 'M':
        return Weapon.m(size, hasReact: hasReact);
      case 'MW':
        return Weapon.mw(size, hasReact: hasReact);
      case 'P':
        return Weapon.p(size, hasReact: hasReact);
      case 'PA':
        return Weapon.pa(size, hasReact: hasReact);
      case 'PC':
        return switch (size) {
          WeaponSize.light => Weapon.pcLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.pcMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.pcHeavy(hasReact: hasReact),
        };
      case 'PL':
        return switch (size) {
          WeaponSize.light => Weapon.plLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.plMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.plHeavy(hasReact: hasReact),
        };
      case 'PZ':
        return switch (size) {
          WeaponSize.light => Weapon.pzLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.pzMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.pzHeavy(hasReact: hasReact),
        };
      case 'RC':
        return Weapon.rc(size, hasReact: hasReact);
      case 'RF':
        return Weapon.rf(size, hasReact: hasReact);
      case 'RG':
        return switch (size) {
          WeaponSize.light => Weapon.rgLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.rgMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.rgHeavy(hasReact: hasReact),
        };
      case 'RL':
        return Weapon.rl(size, hasReact: hasReact);
      case 'RP':
        return Weapon.rp(size, hasReact: hasReact);
      case 'SC':
        return switch (size) {
          WeaponSize.light => Weapon.scLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.scMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.scHeavy(hasReact: hasReact),
        };
      case 'SE':
        return switch (size) {
          WeaponSize.light => Weapon.seLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.seMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.seHeavy(hasReact: hasReact),
        };
      case 'SG':
        return switch (size) {
          WeaponSize.light => Weapon.sgLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.sgMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.sgHeavy(hasReact: hasReact),
        };
      case 'SMG':
        return Weapon.smg(size, hasReact: hasReact);
      case 'TG':
        return switch (size) {
          WeaponSize.light => Weapon.tgLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.tgMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.tgHeavy(hasReact: hasReact),
        };
      case 'VB':
        return switch (size) {
          WeaponSize.light => Weapon.vbLight(hasReact: hasReact),
          WeaponSize.medium => Weapon.vbMedium(hasReact: hasReact),
          WeaponSize.heavy => Weapon.vbHeavy(hasReact: hasReact),
        };
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
