package roster

import (
	"github.com/Ariemeth/gearforce/gear"
)

// ForceOrg contains the information needed to represent a heavy gear army roster.
type ForceOrg struct {
	PlayerName  string
	ForceName   string
	Faction     string
	SubFaction  string
	CombatGroup []CombatGroup
}

type CombatGroup struct {
	Primary   Unit
	Secondary Unit
}

type Unit struct {
	Models []SelectedModel
	Name   string
}

type SelectedModel struct {
	Gear     gear.Gear
	Upgrades []interface{}
}
