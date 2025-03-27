typedef UpgradeOptionGenerator = List<String> Function();

class UpgradeOption {
  final UpgradeOptionGenerator optionsGenerator;
  final String? selectedOption;

  UpgradeOption({
    required this.optionsGenerator,
    this.selectedOption,
  });

  UpgradeOption copyWith({
    UpgradeOptionGenerator? optionsGenerator,
    String? selectedOption,
  }) {
    return UpgradeOption(
      optionsGenerator: optionsGenerator ?? this.optionsGenerator,
      selectedOption: selectedOption ?? this.selectedOption,
    );
  }
}
