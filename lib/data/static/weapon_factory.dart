import 'package:gearforce/data/static/catalogs/weapon_catalog.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart';

class WeaponFactory {
  static List<Weapon> getAllWeapons({WeaponSize size = WeaponSize.light}) {
    return [
      WeaponCatalog.aam(size),
      WeaponCatalog.ac(size),
      WeaponCatalog.ag(size),
      WeaponCatalog.am(size),
      WeaponCatalog.apgl(size),
      WeaponCatalog.ar(size),
      WeaponCatalog.atm(size),
      WeaponCatalog.bomb(size),
      WeaponCatalog.napalm(size),
      WeaponCatalog.bz(size),
      WeaponCatalog.rbz(size),
      WeaponCatalog.flc(size),
      WeaponCatalog.fg(size),
      WeaponCatalog.fc(size),
      WeaponCatalog.fl(size),
      WeaponCatalog.gg(size),
      WeaponCatalog.gl(size),
      WeaponCatalog.hg(size),
      WeaponCatalog.iatm(size),
      WeaponCatalog.ic(size),
      WeaponCatalog.igl(size),
      WeaponCatalog.ilw(size),
      WeaponCatalog.ilsr(size),
      WeaponCatalog.im(size),
      WeaponCatalog.img(size),
      WeaponCatalog.imw(size),
      WeaponCatalog.ir(size),
      WeaponCatalog.irc(size),
      WeaponCatalog.iw(size),
      WeaponCatalog.lc(size),
      WeaponCatalog.mine(size),
      WeaponCatalog.m(size),
      WeaponCatalog.mw(size),
      WeaponCatalog.p(size),
      WeaponCatalog.pa(size),
      WeaponCatalog.pc(size),
      WeaponCatalog.pl(size),
      WeaponCatalog.pz(size),
      WeaponCatalog.rc(size),
      WeaponCatalog.rf(size),
      WeaponCatalog.rg(size),
      WeaponCatalog.rl(size),
      WeaponCatalog.rp(size),
      WeaponCatalog.sc(size),
      WeaponCatalog.se(size),
      WeaponCatalog.sg(size),
      WeaponCatalog.smg(size),
      WeaponCatalog.tg(size),
      WeaponCatalog.vb(size),
    ];
  }

  static Weapon? getWeaponByCode(String code, {bool hasReact = false}) {
    final size = WeaponSize.fromCode(code);
    switch (code.substring(1)) {
      case 'AAM':
        return WeaponCatalog.aam(size, hasReact: hasReact);
      case 'AC':
        return WeaponCatalog.ac(size, hasReact: hasReact);
      case 'AG':
        return WeaponCatalog.ag(size, hasReact: hasReact);
      case 'AM':
        return WeaponCatalog.am(size, hasReact: hasReact);
      case 'APGL':
        return WeaponCatalog.apgl(size, hasReact: hasReact);
      case 'AR':
        return WeaponCatalog.ar(size, hasReact: hasReact);
      case 'ATM':
        return WeaponCatalog.atm(size, hasReact: hasReact);
      case 'Bomb':
        return WeaponCatalog.bomb(size, hasReact: hasReact);
      case 'Napalm':
        return WeaponCatalog.napalm(size, hasReact: hasReact);
      case 'BZ':
        return WeaponCatalog.bz(size, hasReact: hasReact);
      case 'RBZ':
        return WeaponCatalog.rbz(size, hasReact: hasReact);
      case 'FLC':
        return WeaponCatalog.flc(size, hasReact: hasReact);
      case 'FG':
        return WeaponCatalog.fg(size, hasReact: hasReact);
      case 'FC':
        return WeaponCatalog.fc(size, hasReact: hasReact);
      case 'FL':
        return WeaponCatalog.fl(size, hasReact: hasReact);
      case 'GG':
        return WeaponCatalog.gg(size, hasReact: hasReact);
      case 'GL':
        return WeaponCatalog.gl(size, hasReact: hasReact);
      case 'HG':
        return WeaponCatalog.hg(size, hasReact: hasReact);
      case 'IATM':
        return WeaponCatalog.iatm(size, hasReact: hasReact);
      case 'IC':
        return WeaponCatalog.ic(size, hasReact: hasReact);
      case 'IGL':
        return WeaponCatalog.igl(size, hasReact: hasReact);
      case 'ILW':
        return WeaponCatalog.ilw(size, hasReact: hasReact);
      case 'ILSR':
        return WeaponCatalog.ilsr(size, hasReact: hasReact);
      case 'IM':
        return WeaponCatalog.im(size, hasReact: hasReact);
      case 'IMG':
        return WeaponCatalog.img(size, hasReact: hasReact);
      case 'IMW':
        return WeaponCatalog.imw(size, hasReact: hasReact);
      case 'IR':
        return WeaponCatalog.ir(size, hasReact: hasReact);
      case 'IRC':
        return WeaponCatalog.irc(size, hasReact: hasReact);
      case 'IW':
        return WeaponCatalog.iw(size, hasReact: hasReact);
      case 'LC':
        return WeaponCatalog.lc(size, hasReact: hasReact);
      case 'Mine':
        return WeaponCatalog.mine(size, hasReact: hasReact);
      case 'M':
        return WeaponCatalog.m(size, hasReact: hasReact);
      case 'MW':
        return WeaponCatalog.mw(size, hasReact: hasReact);
      case 'P':
        return WeaponCatalog.p(size, hasReact: hasReact);
      case 'PA':
        return WeaponCatalog.pa(size, hasReact: hasReact);
      case 'PC':
        return WeaponCatalog.pc(size, hasReact: hasReact);
      case 'PL':
        return WeaponCatalog.pl(size, hasReact: hasReact);
      case 'PZ':
        return WeaponCatalog.pz(size, hasReact: hasReact);
      case 'RC':
        return WeaponCatalog.rc(size, hasReact: hasReact);
      case 'RF':
        return WeaponCatalog.rf(size, hasReact: hasReact);
      case 'RG':
        return WeaponCatalog.rg(size, hasReact: hasReact);
      case 'RL':
        return WeaponCatalog.rl(size, hasReact: hasReact);
      case 'RP':
        return WeaponCatalog.rp(size, hasReact: hasReact);
      case 'SC':
        return WeaponCatalog.sc(size, hasReact: hasReact);
      case 'SE':
        return WeaponCatalog.se(size, hasReact: hasReact);
      case 'SG':
        return WeaponCatalog.sg(size, hasReact: hasReact);
      case 'SMG':
        return WeaponCatalog.smg(size, hasReact: hasReact);
      case 'TG':
        return WeaponCatalog.tg(size, hasReact: hasReact);
      case 'VB':
        return WeaponCatalog.vb(size, hasReact: hasReact);
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
