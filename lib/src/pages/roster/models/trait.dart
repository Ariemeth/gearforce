import 'package:meta/meta.dart';

@immutable
class Trait {
  final String name;
  final String? description;
  final String? shortenedName;
  final int? level;
  final String? type;
  final bool isAux;

  const Trait({
    required this.name,
    this.description,
    this.shortenedName,
    this.level,
    this.type,
    this.isAux = false,
  });

  // Factory methods for predefined traits
  factory Trait.agile({bool isAux = false, int? level, String? type}) {
    return Trait(
      name: 'Agile',
      description: 'This unit is highly maneuverable.',
      shortenedName: 'AGL',
      isAux: isAux,
      level: level,
      type: type,
    );
  }

  factory Trait.hands({bool isAux = false, int? level, String? type}) {
    return Trait(
      name: 'Hands',
      description: 'This unit has hands.',
      isAux: isAux,
      level: level,
      type: type,
    );
  }

  factory Trait.sensors({bool isAux = false, int? level, String? type}) {
    return Trait(
      name: 'Sensors',
      description: 'This unit has greater sensor range.',
      level: level ?? 36,
      isAux: isAux,
      type: type,
    );
  }

  factory Trait.fromName(String name) {
    final isAux = name.toLowerCase().contains('(aux)');
    final levelMatch = RegExp(r':(\d+)(?:\s+(\w+))?$').firstMatch(name);
    final level = levelMatch != null ? int.parse(levelMatch.group(1)!) : null;
    final type = levelMatch?.group(2);
    final cleanName = name
        .replaceAll(RegExp(r'\s*\(aux\)', caseSensitive: false), '')
        .replaceAll(RegExp(r':\d+(?:\s+\w+)?$'), '')
        .trim();

    switch (cleanName.toLowerCase()) {
      case 'agile':
        return Trait.agile(isAux: isAux, level: level, type: type);
      case 'hands':
        return Trait.hands(isAux: isAux, level: level, type: type);
      case 'sensors':
        return Trait.sensors(isAux: isAux, level: level, type: type);
      default:
        throw ArgumentError('Unknown trait name: $cleanName');
    }
  }

  Trait copyWith({
    String? name,
    int? level,
    String? type,
    bool? isAux,
  }) {
    return Trait(
      name: name ?? this.name,
      description: description, // Prevent changes to description
      shortenedName: shortenedName, // Prevent changes to shortenedName
      level: level ?? this.level,
      type: type ?? this.type,
      isAux: isAux ?? this.isAux,
    );
  }

  @override
  String toString() {
    final codeDisplay = shortenedName?.toUpperCase();
    final codePart = codeDisplay != null ? ' [$codeDisplay]' : '';
    final typePart = type != null ? ' ($type)' : '';
    if (level != null) {
      return '$name$codePart (Level $level)$typePart: ${description ?? 'No description'}';
    }
    return '$name$codePart$typePart: ${description ?? 'No description'}';
  }
}
