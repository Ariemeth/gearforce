import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/unit_attribute_widgets.dart';

/// A row showing a right-aligned label and a [Wrap] of child widgets.
///
/// Used for displaying weapons and traits in unit/model cards:
/// ```
/// React Weapons:  LRP, MRP, ...
/// Mounted Weapons: MAC, ...
/// Traits:          Hands, ECM, ...
/// ```
class WeaponTraitRow extends StatelessWidget {
  const WeaponTraitRow({
    super.key,
    required this.label,
    required this.children,
  });

  /// The label text displayed on the left (e.g. "React Weapons:").
  final String label;

  /// The chip widgets displayed in a wrapping layout on the right.
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: AppTheme.weaponAndTraitLabelWidth,
          child: UnitAttributeLabel(label, textAlign: TextAlign.right),
        ),
        const SizedBox(width: AppTheme.weaponAndTraitLabelGap),
        Expanded(child: Wrap(spacing: 0, runSpacing: 2, children: children)),
      ],
    );
  }
}
