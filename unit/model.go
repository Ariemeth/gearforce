package unit

import (
	"fmt"
	"io/ioutil"
	"strings"

	"gopkg.in/yaml.v2"
)

// Model represents the stats for any game model.
type Model struct {
	Model     string        `yaml:"model"`
	SubModel  string        `yaml:"sub"`
	TV        uint          `yaml:"tv"`
	UA        []string      `yaml:"ua"`
	Movement  []interface{} `yaml:"movement"`
	Armor     uint          `yaml:"armor"`
	Hull      uint          `yaml:"hull"`
	Structure uint          `yaml:"structure"`
	Actions   uint          `yaml:"actions"`
	Gunnery   uint          `yaml:"gunnery"`
	Piloting  uint          `yaml:"piloting"`
	EW        uint          `yaml:"ew"`
	Weapons   []interface{} `yaml:"weapons"`
	Traits    []interface{} `yaml:"traits"`
	Type      string        `yaml:"type"`
	Height    float32       `yaml:"height"`
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

func load(filename string) (Model, error) {
	var m Model

	data, err := ioutil.ReadFile(filename)
	if err != nil {
		fmt.Printf("Error loading %s, %f\n", filename, err)
		return Model{}, err
	}
	err = yaml.Unmarshal(data, &m)
	if err != nil {
		fmt.Printf("Error unmarshalling %s, %s\n", filename, err)
		return Model{}, err
	}

	return m, nil
}
