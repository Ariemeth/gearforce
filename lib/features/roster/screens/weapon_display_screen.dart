import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/domain/entities/equipment/weapon_size.dart'
    show WeaponSize;
import 'package:gearforce/domain/repositories/weapon_repository.dart';
import 'package:gearforce/core/theme/app_theme.dart';

class WeaponDisplayScreen extends StatefulWidget {
  static const routeName = '/weapons';

  const WeaponDisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeaponDisplayScreenState();
}

class _WeaponDisplayScreenState extends State<WeaponDisplayScreen> {
  List<Weapon> weapons = [];
  bool _isLoading = true;
  bool _hasLoadedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedOnce) {
      _hasLoadedOnce = true;
      _loadWeapons();
    }
  }

  Future<void> _loadWeapons() async {
    final repository = context.read<WeaponRepository>();
    final loadedWeapons = await repository.getWeapons();
    if (mounted) {
      setState(() {
        weapons = loadedWeapons;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(context.l10n.weaponsTitle, style: AppTheme.titleStyle),
        ),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(child: _buildTable()),
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
