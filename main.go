package main

import (
	"fmt"

	"github.com/Ariemeth/gearforce/roster"
	"github.com/Ariemeth/gearforce/unit"
)

func main() {

	m1 := roster.SelectedModel{Model: unit.Hunter}
	u1 := roster.Unit{Models: []roster.SelectedModel{m1}}
	cg1 := roster.CombatGroup{Primary: u1}

	r := roster.ForceOrg{
		Faction:     "North",
		CombatGroup: []roster.CombatGroup{cg1},
	}
	fmt.Println(r)
}
