import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/equipment/weapon.dart';
import 'package:gearforce/data/static/weapon_factory.dart';
import 'package:gearforce/features/roster/widgets/weapon_data_table.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';

const double _maxContentWidth = 1200;

class WeaponDisplayScreen extends StatefulWidget {
  static const routeName = '/weapons';

  const WeaponDisplayScreen({super.key});

  @override
  State<StatefulWidget> createState() => _WeaponDisplayScreenState();
}

class _WeaponDisplayScreenState extends State<WeaponDisplayScreen> {
  List<Weapon> weapons = [];
  bool _hasLoadedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedOnce) {
      _hasLoadedOnce = true;
      _loadWeapons();
    }
  }

  void _loadWeapons() {
    setState(() {
      weapons = WeaponFactory.getAllWeapons();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(context.l10n.weaponsTitle, style: AppTheme.titleStyle),
        ),
      ),
      body: ConstrainedContent(
        maxWidth: _maxContentWidth,
        child: SingleChildScrollView(child: WeaponDataTable(weapons: weapons)),
      ),
    );
  }
}
