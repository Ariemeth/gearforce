enum Faction {
  blackTalons,
  cef,
  caprice,
  eden,
  north,
  nuCoal,
  peaceRiver,
  south,
  utopia,
}

extension FactionExtension on Faction {
  String get displayName {
    switch (this) {
      case Faction.blackTalons:
        return 'Black Talons';
      case Faction.cef:
        return 'CEF';
      case Faction.caprice:
        return 'Caprice';
      case Faction.eden:
        return 'Eden';
      case Faction.north:
        return 'North';
      case Faction.nuCoal:
        return 'NuCoal';
      case Faction.peaceRiver:
        return 'Peace River';
      case Faction.south:
        return 'South';
      case Faction.utopia:
        return 'Utopia';
    }
  }
}
