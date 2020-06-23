package unit

const (
	North      = "North"
	South      = "South"
	PeaceRiver = "Peace River"
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

func GetFactionUnits(faction string) Models {

	switch faction {
	case North:
		return NorthernUnits()
	case South:
		return SoutherUnits()
	case PeaceRiver:
		return PeaceRiverUnits()
	}
	return nil
}
