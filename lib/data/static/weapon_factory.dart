import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';

class WeaponFactory {
  static List<Weapon> getAllWeapons({WeaponSize size = WeaponSize.light}) {
    return [
      Weapon.aam(size),
      Weapon.ac(size),
      Weapon.ag(size),
      Weapon.am(size),
      Weapon.apgl(size),
      Weapon.ar(size),
      Weapon.atm(size),
      Weapon.bomb(size),
      Weapon.napalm(size),
      Weapon.bz(size),
      Weapon.rbz(size),
      Weapon.fc(size),
      Weapon.fg(size),
      Weapon.fk(size),
      Weapon.fl(size),
      Weapon.gg(size),
      Weapon.gl(size),
      Weapon.hg(size),
      Weapon.iatm(size),
      Weapon.ic(size),
      Weapon.igl(size),
      Weapon.ilw(size),
      Weapon.ilsr(size),
      Weapon.im(size),
      Weapon.img(size),
      Weapon.imw(size),
      Weapon.ir(size),
      Weapon.irc(size),
      Weapon.iw(size),
      Weapon.lc(size),
      Weapon.mine(size),
      Weapon.m(size),
      Weapon.mw(size),
      Weapon.p(size),
      Weapon.pa(size),
      Weapon.pc(size),
      Weapon.pl(size),
      Weapon.pz(size),
      Weapon.rc(size),
      Weapon.rf(size),
      Weapon.rg(size),
      Weapon.rl(size),
      Weapon.rp(size),
      Weapon.sc(size),
      Weapon.se(size),
      Weapon.sg(size),
      Weapon.smg(size),
      Weapon.tg(size),
      Weapon.vb(size),
    ];
  }

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
        return Weapon.atm(size, hasReact: hasReact);
      case 'Bomb':
        return Weapon.bomb(size, hasReact: hasReact);
      case 'Napalm':
        return Weapon.napalm(size, hasReact: hasReact);
      case 'BZ':
        return Weapon.bz(size, hasReact: hasReact);
      case 'RBZ':
        return Weapon.rbz(size, hasReact: hasReact);
      case 'FC':
        return Weapon.fc(size, hasReact: hasReact);
      case 'FG':
        return Weapon.fg(size, hasReact: hasReact);
      case 'FK':
        return Weapon.fk(size, hasReact: hasReact);
      case 'FL':
        return Weapon.fl(size, hasReact: hasReact);
      case 'GG':
        return Weapon.gg(size, hasReact: hasReact);
      case 'GL':
        return Weapon.gl(size, hasReact: hasReact);
      case 'HG':
        return Weapon.hg(size, hasReact: hasReact);
      case 'IATM':
        return Weapon.iatm(size, hasReact: hasReact);
      case 'IC':
        return Weapon.ic(size, hasReact: hasReact);
      case 'IGL':
        return Weapon.igl(size, hasReact: hasReact);
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
      case 'IRC':
        return Weapon.irc(size, hasReact: hasReact);
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
        return Weapon.pc(size, hasReact: hasReact);
      case 'PL':
        return Weapon.pl(size, hasReact: hasReact);
      case 'PZ':
        return Weapon.pz(size, hasReact: hasReact);
      case 'RC':
        return Weapon.rc(size, hasReact: hasReact);
      case 'RF':
        return Weapon.rf(size, hasReact: hasReact);
      case 'RG':
        return Weapon.rg(size, hasReact: hasReact);
      case 'RL':
        return Weapon.rl(size, hasReact: hasReact);
      case 'RP':
        return Weapon.rp(size, hasReact: hasReact);
      case 'SC':
        return Weapon.sc(size, hasReact: hasReact);
      case 'SE':
        return Weapon.se(size, hasReact: hasReact);
      case 'SG':
        return Weapon.sg(size, hasReact: hasReact);
      case 'SMG':
        return Weapon.smg(size, hasReact: hasReact);
      case 'TG':
        return Weapon.tg(size, hasReact: hasReact);
      case 'VB':
        return Weapon.vb(size, hasReact: hasReact);
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
