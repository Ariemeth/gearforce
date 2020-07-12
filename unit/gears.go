package unit

var Hunter = Model{
	Model:     "Hunter",
	SubModel:  "",
	TV:        6,
	UA:        []string{"GP+", "SK", "FS"},
	Movement:  []interface{}{"W/G:6"},
	Actions:   1,
	Armor:     6,
	Hull:      4,
	Structure: 2,
	Gunnery:   4,
	Piloting:  4,
	EW:        6,
	Weapons:   []interface{}{"LAC (Arm)", "LRP", "LAPGL", "LPZ", "LVB (Arm)"},
	Traits:    []interface{}{"Arms"},
	Type:      "gear",
	Height:    1.5,
	//Upgrades:
}

var warrior = Model{
	Model:     "Warrior",
	SubModel:  "",
	TV:        7,
	UA:        []string{"GP+", "SK", "FS"},
	Movement:  []interface{}{"W/G:6"},
	Actions:   1,
	Armor:     6,
	Hull:      4,
	Structure: 2,
	Gunnery:   4,
	Piloting:  4,
	EW:        5,
	Weapons:   []interface{}{"LAC (Arm)", "LRP", "LAPGL", "LVB (Arm)"},
	Traits:    []interface{}{"Arms", "ECM"},
	Type:      "gear",
	Height:    1.5,
	//Upgrades:
}

var jager = Model{
	Model:     "Jager",
	SubModel:  "",
	TV:        6,
	UA:        []string{"GP+", "SK", "FS"},
	Movement:  []interface{}{"W/G:6"},
	Actions:   1,
	Armor:     6,
	Hull:      4,
	Structure: 2,
	Gunnery:   4,
	Piloting:  4,
	EW:        6,
	Weapons:   []interface{}{"LAC (Arm)", "LRP", "LAPGL", "LHG", "LVB (Arm)"},
	Traits:    []interface{}{"Arms"},
	Type:      "gear",
	Height:    1.5,
	//Upgrades:
}
