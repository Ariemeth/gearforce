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
          WeaponSize.light => Weapon.atmL(hasReact: hasReact),
          WeaponSize.medium => Weapon.atmM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.atmH(hasReact: hasReact),
        };
      case 'Bomb':
        return Weapon.bomb(size, hasReact: hasReact);
      case 'Napalm':
        return switch (size) {
          WeaponSize.light => Weapon.napalmL(hasReact: hasReact),
          WeaponSize.medium => Weapon.napalmM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.napalmH(hasReact: hasReact),
        };
      case 'BZ':
        return switch (size) {
          WeaponSize.light => Weapon.bzL(hasReact: hasReact),
          WeaponSize.medium => Weapon.bzM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.bzH(hasReact: hasReact),
        };
      case 'RBZ':
        return switch (size) {
          WeaponSize.light => Weapon.rbzL(hasReact: hasReact),
          WeaponSize.medium => Weapon.rbzM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.rbzH(hasReact: hasReact),
        };
      case 'FC':
        return switch (size) {
          WeaponSize.light => Weapon.fcL(hasReact: hasReact),
          WeaponSize.medium => Weapon.fcM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.fcH(hasReact: hasReact),
        };
      case 'FG':
        return switch (size) {
          WeaponSize.light => Weapon.fgL(hasReact: hasReact),
          WeaponSize.medium => Weapon.fgM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.fgH(hasReact: hasReact),
        };
      case 'FL':
        return switch (size) {
          WeaponSize.light => Weapon.flL(hasReact: hasReact),
          WeaponSize.medium => Weapon.flM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.flH(hasReact: hasReact),
        };
      case 'GG':
        return switch (size) {
          WeaponSize.light => Weapon.ggL(hasReact: hasReact),
          WeaponSize.medium => Weapon.ggM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.ggH(hasReact: hasReact),
        };
      case 'GL':
        return switch (size) {
          WeaponSize.light => Weapon.glL(hasReact: hasReact),
          WeaponSize.medium => Weapon.glM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.glH(hasReact: hasReact),
        };
      case 'HG':
        return switch (size) {
          WeaponSize.light => Weapon.hgL(hasReact: hasReact),
          WeaponSize.medium => Weapon.hgM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.hgH(hasReact: hasReact),
        };
      case 'IATM':
        return switch (size) {
          WeaponSize.light => Weapon.iatmL(hasReact: hasReact),
          WeaponSize.medium => Weapon.iatmM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.iatmH(hasReact: hasReact),
        };
      case 'IGL':
        return switch (size) {
          WeaponSize.light => Weapon.iglL(hasReact: hasReact),
          WeaponSize.medium => Weapon.iglM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.iglH(hasReact: hasReact),
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
          WeaponSize.light => Weapon.pcL(hasReact: hasReact),
          WeaponSize.medium => Weapon.pcM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.pcH(hasReact: hasReact),
        };
      case 'PL':
        return switch (size) {
          WeaponSize.light => Weapon.plL(hasReact: hasReact),
          WeaponSize.medium => Weapon.plM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.plH(hasReact: hasReact),
        };
      case 'PZ':
        return switch (size) {
          WeaponSize.light => Weapon.pzL(hasReact: hasReact),
          WeaponSize.medium => Weapon.pzM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.pzH(hasReact: hasReact),
        };
      case 'RC':
        return Weapon.rc(size, hasReact: hasReact);
      case 'RF':
        return Weapon.rf(size, hasReact: hasReact);
      case 'RG':
        return switch (size) {
          WeaponSize.light => Weapon.rgL(hasReact: hasReact),
          WeaponSize.medium => Weapon.rgM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.rgH(hasReact: hasReact),
        };
      case 'RL':
        return Weapon.rl(size, hasReact: hasReact);
      case 'RP':
        return Weapon.rp(size, hasReact: hasReact);
      case 'SC':
        return switch (size) {
          WeaponSize.light => Weapon.scL(hasReact: hasReact),
          WeaponSize.medium => Weapon.scM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.scH(hasReact: hasReact),
        };
      case 'SE':
        return switch (size) {
          WeaponSize.light => Weapon.seL(hasReact: hasReact),
          WeaponSize.medium => Weapon.seM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.seH(hasReact: hasReact),
        };
      case 'SG':
        return switch (size) {
          WeaponSize.light => Weapon.sgL(hasReact: hasReact),
          WeaponSize.medium => Weapon.sgM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.sgH(hasReact: hasReact),
        };
      case 'SMG':
        return Weapon.smg(size, hasReact: hasReact);
      case 'TG':
        return switch (size) {
          WeaponSize.light => Weapon.tgL(hasReact: hasReact),
          WeaponSize.medium => Weapon.tgM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.tgH(hasReact: hasReact),
        };
      case 'VB':
        return switch (size) {
          WeaponSize.light => Weapon.vbL(hasReact: hasReact),
          WeaponSize.medium => Weapon.vbM(hasReact: hasReact),
          WeaponSize.heavy => Weapon.vbH(hasReact: hasReact),
        };
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
