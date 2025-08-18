class Rule {
  final String name;
  final String id;
  final String description;
  bool isEnabled;
  bool canBeToggled;

  Rule({
    required this.name,
    required this.id,
    required this.description,
    this.isEnabled = true,
    this.canBeToggled = false,
  });
}
