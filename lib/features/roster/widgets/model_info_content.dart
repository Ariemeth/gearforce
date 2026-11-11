import 'package:material_ui/material_ui.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/domain/entities/attribute/command.dart';
import 'package:gearforce/domain/entities/unit/model.dart';

class ModelInfoContent extends StatelessWidget {
  final Model model;
  final String squadName;

  const ModelInfoContent({
    super.key,
    required this.model,
    required this.squadName,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _InfoRow(label: 'Chasis', value: model.base.name),
        _InfoRow(label: 'Variant', value: model.variant.name),
        _InfoRow(label: 'Level', value: model.level.name),
        _InfoRow(label: 'Command', value: _commandLabel(model.command)),
        _InfoRow(label: 'Duelist', value: model.isDuelist ? 'Yes' : 'No'),
        _InfoRow(label: 'Height', value: model.height.toStringAsFixed(1)),
        _InfoRow(label: 'Squad', value: squadName),
      ],
    );
  }

  String _commandLabel(Command command) {
    if (command == Command.none) {
      return 'None';
    }
    return command.name;
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          SizedBox(
            width: 110,
            child: Text(
              '$label:',
              style: AppTheme.bodyStyle.copyWith(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(child: Text(value, style: AppTheme.bodyStyle)),
        ],
      ),
    );
  }
}
