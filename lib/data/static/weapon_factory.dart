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

  static Weapon? getWeaponByCode(String code) {
    final size = WeaponSize.fromCode(code);
    switch (code.substring(1)) {
      case 'AAM':
        return WeaponCatalog.aam(size);
      case 'AC':
        return WeaponCatalog.ac(size);
      case 'AG':
        return WeaponCatalog.ag(size);
      case 'AM':
        return WeaponCatalog.am(size);
      case 'APGL':
        return WeaponCatalog.apgl(size);
      case 'AR':
        return WeaponCatalog.ar(size);
      case 'ATM':
        return WeaponCatalog.atm(size);
      case 'Bomb':
        return WeaponCatalog.bomb(size);
      case 'Napalm':
        return WeaponCatalog.napalm(size);
      case 'BZ':
        return WeaponCatalog.bz(size);
      case 'RBZ':
        return WeaponCatalog.rbz(size);
      case 'FLC':
        return WeaponCatalog.flc(size);
      case 'FG':
        return WeaponCatalog.fg(size);
      case 'FC':
        return WeaponCatalog.fc(size);
      case 'FL':
        return WeaponCatalog.fl(size);
      case 'GG':
        return WeaponCatalog.gg(size);
      case 'GL':
        return WeaponCatalog.gl(size);
      case 'HG':
        return WeaponCatalog.hg(size);
      case 'IATM':
        return WeaponCatalog.iatm(size);
      case 'IC':
        return WeaponCatalog.ic(size);
      case 'IGL':
        return WeaponCatalog.igl(size);
      case 'ILW':
        return WeaponCatalog.ilw(size);
      case 'ILSR':
        return WeaponCatalog.ilsr(size);
      case 'IM':
        return WeaponCatalog.im(size);
      case 'IMG':
        return WeaponCatalog.img(size);
      case 'IMW':
        return WeaponCatalog.imw(size);
      case 'IR':
        return WeaponCatalog.ir(size);
      case 'IRC':
        return WeaponCatalog.irc(size);
      case 'IW':
        return WeaponCatalog.iw(size);
      case 'LC':
        return WeaponCatalog.lc(size);
      case 'Mine':
        return WeaponCatalog.mine(size);
      case 'M':
        return WeaponCatalog.m(size);
      case 'MW':
        return WeaponCatalog.mw(size);
      case 'P':
        return WeaponCatalog.p(size);
      case 'PA':
        return WeaponCatalog.pa(size);
      case 'PC':
        return WeaponCatalog.pc(size);
      case 'PL':
        return WeaponCatalog.pl(size);
      case 'PZ':
        return WeaponCatalog.pz(size);
      case 'RC':
        return WeaponCatalog.rc(size);
      case 'RF':
        return WeaponCatalog.rf(size);
      case 'RG':
        return WeaponCatalog.rg(size);
      case 'RL':
        return WeaponCatalog.rl(size);
      case 'RP':
        return WeaponCatalog.rp(size);
      case 'SC':
        return WeaponCatalog.sc(size);
      case 'SE':
        return WeaponCatalog.se(size);
      case 'SG':
        return WeaponCatalog.sg(size);
      case 'SMG':
        return WeaponCatalog.smg(size);
      case 'TG':
        return WeaponCatalog.tg(size);
      case 'VB':
        return WeaponCatalog.vb(size);
      default:
        return null; // Return null if no matching weapon is found
    }
  }
}
