import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gearforce/core/utils/l10n_extension.dart';
import 'package:gearforce/domain/entities/unit/squad.dart';
import 'package:gearforce/domain/entities/unit/model.dart';
import 'package:gearforce/domain/entities/unit/unit.dart';
import 'package:gearforce/domain/entities/unit/unit_list_extensions.dart';
import 'package:gearforce/features/roster/bloc/roster_bloc.dart';
import 'package:gearforce/features/roster/widgets/model_list_card.dart';
import 'package:gearforce/domain/specifications/unit_filters.dart';
import 'package:gearforce/core/theme/app_theme.dart';
import 'package:gearforce/core/widgets/constrained_content.dart';

const double _modelListIndentWidth = 10.0;
const double _maxContentWidth = 900;

class UnitSelectionScreen extends StatefulWidget {
  const UnitSelectionScreen({super.key, required this.updatedSquad});

  final Squad updatedSquad;

  @override
  State<UnitSelectionScreen> createState() => _UnitSelectionScreenState();
}

class _UnitSelectionScreenState extends State<UnitSelectionScreen> {
  final List<bool> _expandedStates = [];
  List<Unit> _availableUnits = [];
  bool _isLoading = true;
  bool _hasLoadedOnce = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_hasLoadedOnce) {
      _hasLoadedOnce = true;
      _loadAvailableUnits();
    }
  }

  Future<void> _loadAvailableUnits() async {
    final rosterBloc = context.read<RosterBloc>();
    final rosterState = rosterBloc.state;

    final squadRoles = {
      widget.updatedSquad.primaryRole,
      if (widget.updatedSquad.secondaryRole != null)
        widget.updatedSquad.secondaryRole!,
    };

    final units = await rosterState.ruleSet.getAvailableUnits();
    final filteredUnits = units
        .filterBy(UnitFilters.matchByUnitAndVariantRoles(squadRoles))
        .toList();

    if (mounted) {
      setState(() {
        _availableUnits = filteredUnits;
        _isLoading = false;
        _expandedStates.addAll(
          List<bool>.filled(_availableUnits.length, false),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(context.l10n.selectUnitTitle, style: AppTheme.titleStyle),
        ),
      ),
      body: ConstrainedContent(
        maxWidth: _maxContentWidth,
        padding: AppTheme.defaultPagePadding,
        child: SingleChildScrollView(
          child: ExpansionPanelList(
            expandedHeaderPadding: const EdgeInsets.fromLTRB(0, 4, 0, 4),
            expansionCallback: (index, isExpanded) {
              setState(() {
                _expandedStates[index] = isExpanded;
              });
            },
            children: _availableUnits.map((unit) {
              final index = _availableUnits.indexOf(unit);
              return ExpansionPanel(
                canTapOnHeader: true,
                headerBuilder: (context, isExpanded) {
                  return _UnitListHeader(unit);
                },
                body: Padding(
                  padding: const EdgeInsets.only(left: _modelListIndentWidth),
                  child: _UnitModelList(unit, widget.updatedSquad),
                ),
                splashColor: Colors.blue.shade200,
                isExpanded: _expandedStates[index],
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class _UnitListHeader extends StatelessWidget {
  final Unit unit;
  const _UnitListHeader(this.unit);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue.shade100,
      child: Column(
        children: [
          Text(unit.name, style: AppTheme.titleStyle),
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              context.l10n.variantsCount(unit.variants.length),
              style: TextStyle(fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }
}

class _UnitModelList extends StatelessWidget {
  const _UnitModelList(this.unit, this.updatedSquad);

  final Squad updatedSquad;
  final Unit unit;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: unit.variants.map((variant) {
        bool isHovered = false;
        return StatefulBuilder(
          builder: (context, setState) {
            return MouseRegion(
              onEnter: (_) {
                setState(() {
                  isHovered = true;
                });
              },
              onExit: (_) {
                setState(() {
                  isHovered = false;
                });
              },
              child: GestureDetector(
                onTap: () {
                  context.read<RosterBloc>().add(
                    AddModel(
                      squad: updatedSquad,
                      base: unit.base,
                      variant: variant,
                    ),
                  );

                  Navigator.pop(context);
                },
                child: Container(
                  color: isHovered
                      ? Theme.of(
                          context,
                        ).colorScheme.secondaryContainer.withAlpha(90)
                      : Colors.transparent,
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 3.0,
                  ),
                  child: ModelListCard(
                    model: Model(id: -1, base: unit.base, variant: variant),
                  ),
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
