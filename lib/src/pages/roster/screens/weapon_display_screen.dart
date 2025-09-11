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

  DataTable _buildTable() {
    return DataTable(
      columnSpacing: 1.0,
      columns: [
        DataColumn(
          label: Text('Name'),
          onSort: (index, ascending) {
            print('sort name, index:$index, ascending:$ascending');
          },
        ),
        DataColumn(
          label: Text('Code'),
          onSort: (index, ascending) {
            print('sort code, index:$index, ascending:$ascending');
          },
        ),
        DataColumn(
          label: Text('Damage'),
          onSort: (index, ascending) {
            print('sort damage, index:$index, ascending:$ascending');
          },
        ),
      ],
      rows: weapons
          .map(
            (w) => DataRow(
              cells: [
                DataCell(Text(w.name)),
                DataCell(Text(w.baseCode)),
                DataCell(
                  Text(
                    '${w.getDamageForSize(WeaponSize.light)}/${w.getDamageForSize(WeaponSize.medium)}/${w.getDamageForSize(WeaponSize.heavy)}',
                  ),
                ),
              ],
            ),
          )
          .toList(),
    );
  }

  List<Weapon> _lightWeapons() {
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
