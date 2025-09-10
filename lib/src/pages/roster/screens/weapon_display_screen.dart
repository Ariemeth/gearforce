import 'package:flutter/material.dart';
import 'package:gearforce/src/theme/app_theme.dart';

class WeaponDisplayScreen extends StatefulWidget {
  static const routeName = '/weapons';

  const WeaponDisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeaponDisplayScreenState();
}

class _WeaponDisplayScreenState extends State<WeaponDisplayScreen> {
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
      rows: const [
        DataRow(
          cells: [
            DataCell(Text('Autocannon')),
            DataCell(Text('AC')),
            DataCell(Text('6')),
          ],
        ),
      ],
    );
  }
}
