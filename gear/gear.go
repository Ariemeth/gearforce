package gear

// Gear represents a gear model
type Gear struct {
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
}
