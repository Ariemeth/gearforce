package unit

import "github.com/Ariemeth/gearforce/faction"

// Model represents the stats for any game model.
type Model struct {
	Model     string
	SubModel  string
	TV        uint
	UA        []string
	Movement  []interface{}
	Armor     uint
	Hull      uint
	Structure uint
	Actions   uint
	Gunnery   uint
	Piloting  uint
	EW        uint
	Weapons   []interface{}
	Traits    []interface{}
	Type      string
	Height    float32
	Upgrades  []interface{}
}

type Models []Model

func GetFactionUnits(factionName string) Models {

	switch factionName {
	case faction.North:
		return NorthernUnits()
	case faction.South:
		return SoutherUnits()
	case faction.PeaceRiver:
		return PeaceRiverUnits()
	}
	return nil
}

func UALists() []string {
	return []string{
		"GP",
		"SK",
		"FS",
		"RC",
		"SF",
		"PT",
		"VL",
		"AIR",
		"FORT",
	}
}
