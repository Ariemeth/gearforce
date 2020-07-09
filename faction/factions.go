package faction

const (
	// North contains the name of the Northern faction.
	North = "North"
	// South contains the name of the Southern faction.
	South = "South"
	// PeaceRiver contains the name of the Peace River faction.
	PeaceRiver = "Peace River"
)

// Names returns the names of all factions available.
func Names() []string {
	return []string{
		North,
		South,
		PeaceRiver,
	}
}

// SubList returns a list of available sub-factions available to a specific faction.
func SubList(factionName string) []string {
	switch factionName {
	case North:
		return northSubLists()
	case South:
		return southSubLists()
	case PeaceRiver:
		return peaceRiverSubLists()
	}
	return []string{}
}

// northSubLists returns the names of the sub-factions available to the North.
func northSubLists() []string {
	return []string{
		"Northern Guard",
		"Western Frontier Protectorate",
		"United Mercantile Federation",
		"Northern Lights Confederacy",
	}
}

// southSubLists returns the names of the sub-factions available to the South.
func southSubLists() []string {
	return []string{
		"MILitary Intervention and Counter Insurgency Army",
		"Southern Republic Army",
		"Mekong Dominion",
		"Eastern Sun Emirates",
		"Humanist Alliance Protection Force",
	}
}

// peaceRiverSubLists returns the names of the sub-factions available to Peace River.
func peaceRiverSubLists() []string {
	return []string{
		"Peace River Defense Force",
		"Peace Officer Corps",
		"Home Guard Security Forces",
		"Combined Task Force",
		"Protectorate Sponsored Badlands Militia",
	}
}
