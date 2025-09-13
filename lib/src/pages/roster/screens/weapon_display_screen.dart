import 'package:flutter/material.dart';
import 'package:gearforce/src/models/roster/weapon/weapon.dart';
import 'package:gearforce/src/models/roster/weapon/weapon_size.dart'
    show WeaponSize;
import 'package:gearforce/src/theme/app_theme.dart';

class WeaponDisplayScreen extends StatefulWidget {
  static const routeName = '/weapons';

  const WeaponDisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeaponDisplayScreenState();
}

class _WeaponDisplayScreenState extends State<WeaponDisplayScreen> {
  late final List<Weapon> weapons;

  @override
  void initState() {
    super.initState();
    weapons = _lightWeapons();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: const Text('Weapons', style: AppTheme.titleStyle)),
      ),
      body: SingleChildScrollView(child: _buildTable()),
    );
  }

  Widget _buildTable() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 5.0,
        dataRowMinHeight: 20,
        dataRowMaxHeight: 25,
        headingRowHeight: 22,
        columns: [
          DataColumn(label: Text('Code')),
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Range')),
          DataColumn(label: Text('Damage')),
          DataColumn(label: Text('Traits')),
          DataColumn(label: Text('Mode')),
        ],
        rows: weapons
            .map(
              (w) => DataRow(
                cells: [
                  DataCell(Text(w.baseCode)),
                  DataCell(Text(w.name)),
                  DataCell(
                    Text(
                      '${w.range.minOptimal ?? 'NA'}${w.range.maxOptimal != null && w.range.maxOptimal! > 0 ? '-${w.range.maxOptimal}' : ''}/${w.range.max ?? 'NA'}',
                    ),
                  ),
                  DataCell(
                    Text(
                      '${w.getDamageForSize(WeaponSize.light)}/${w.getDamageForSize(WeaponSize.medium)}/${w.getDamageForSize(WeaponSize.heavy)}',
                    ),
                  ),
                  DataCell(
                    Text(
                      '${w.primaryTraits.map((t) => t.name).toList().join(', ')}${w.hasAlternateTraits ? ' or ${w.alternateTraits.map((t) => t.name).toList().join(', ')}' : ''}',
                    ),
                  ),
                  DataCell(
                    Text(w.modes.join(', ').replaceAll('WeaponMode.', '')),
                  ),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  static List<Weapon> _lightWeapons() {
    const size = WeaponSize.light;
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
}
