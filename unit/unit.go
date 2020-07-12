package unit

import (
	"fmt"
	"strings"

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

// IsUA returns true if the model has the requested UA, false otherwise.
func (m Model) IsUA(UA string) bool {
	// If the UA is empty or only whitespace no need to check.
	if strings.TrimSpace(UA) == "" {
		return false
	}

	for _, ua := range m.UA {
		if strings.Contains(strings.ToLower(ua), strings.ToLower(UA)) {
			return true
		}
	}
	return false
}

// Models contains a slice of Model.
type Models []Model

// FilterByUA returns a slice a list of Models that have the specified UA.
func (m Models) FilterByUA(UA string) Models {
	var filterModels = Models{}

	for _, model := range m {
		if model.IsUA(UA) {
			filterModels = append(filterModels, model)
		}
	}

	return filterModels
}

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
