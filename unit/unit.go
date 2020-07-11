package unit

import (
	"fmt"

	"github.com/Ariemeth/gearforce/faction"
)

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

// GetFactionUnits returns a list of models available to a specific faction.
func GetFactionUnits(factionName string) (Models, error) {

	switch factionName {
	case faction.North:
		return NorthernUnits(), nil
	case faction.South:
		return SoutherUnits(), nil
	case faction.PeaceRiver:
		return PeaceRiverUnits(), nil
	}
	return nil, fmt.Errorf("Unknown faction [%s]", factionName)
}

// UALists returns a list of all UA types.
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
