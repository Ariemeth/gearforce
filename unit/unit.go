package unit

import (
	"fmt"

	"github.com/Ariemeth/gearforce/faction"
)

const (
	dataDirectory = "data/units"
)

// GetFactionUnits returns a list of models available to a specific faction.
func GetFactionUnits(factionName string) (Models, error) {

	dataFiles := []string{}

	switch factionName {
	case faction.North:
		dataFiles = northernUnits()
	case faction.South:
		dataFiles = southernUnits()
	case faction.PeaceRiver:
		dataFiles = peaceRiverUnits()
	default:
		return nil, fmt.Errorf("Unknown faction [%s]", factionName)
	}

	models := Models{}
	for _, file := range dataFiles {
		if m, err := load(fmt.Sprintf("%s/%s", dataDirectory, file)); err == nil {
			models = append(models, m)
		} else {
			fmt.Printf("Unable to load %s, %w\n", file, err)
		}
	}
	return models, nil
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
