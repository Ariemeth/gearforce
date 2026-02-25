import 'package:flutter/material.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart'
    show WeaponSize;

/// A DataTable displaying weapon stats.
class WeaponDataTable extends StatelessWidget {
  final List<Weapon> weapons;

  const WeaponDataTable({super.key, required this.weapons});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columnSpacing: 5.0,
        dataRowMinHeight: 20,
        dataRowMaxHeight: 25,
        headingRowHeight: 22,
        columns: [
          DataColumn(label: Text(context.l10n.weaponColumnCode)),
          DataColumn(label: Text(context.l10n.weaponColumnName)),
          DataColumn(label: Text(context.l10n.weaponColumnRange)),
          DataColumn(label: Text(context.l10n.weaponColumnDamage)),
          DataColumn(label: Text(context.l10n.weaponColumnTraits)),
          DataColumn(label: Text(context.l10n.weaponColumnMode)),
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
}
