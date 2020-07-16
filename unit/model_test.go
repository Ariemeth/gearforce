package unit

import (
	"reflect"
	"testing"
)

func TestModel_IsUA(t *testing.T) {
	type fields struct {
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
	type args struct {
		UA string
	}
	tests := []struct {
		name   string
		fields fields
		args   args
		want   bool
	}{
		{
			name: "ua value is empty",
			fields: fields{
				UA: []string{"GP", "FS", ""},
			},
			args: args{UA: ""},
			want: false,
		},
		{
			name: "ua value contains only spaces",
			fields: fields{
				UA: []string{"GP", "FS", "    "},
			},
			args: args{UA: "    "},
			want: false,
		},
		{
			name: "ua value exists",
			fields: fields{
				UA: []string{"GP", "FS"},
			},
			args: args{UA: "GP"},
			want: true,
		},
		{
			name: "ua value exists but wrong case",
			fields: fields{
				UA: []string{"GP", "FS"},
			},
			args: args{UA: "gP"},
			want: true,
		},
		{
			name: "ua value exists with space",
			fields: fields{
				UA: []string{"GP ", "FS"},
			},
			args: args{UA: "GP"},
			want: true,
		},
		{
			name: "ua value does not exist",
			fields: fields{
				UA: []string{"GP", "FS"},
			},
			args: args{UA: "FL"},
			want: false,
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			m := Model{
				Model:     tt.fields.Model,
				SubModel:  tt.fields.SubModel,
				TV:        tt.fields.TV,
				UA:        tt.fields.UA,
				Movement:  tt.fields.Movement,
				Armor:     tt.fields.Armor,
				Hull:      tt.fields.Hull,
				Structure: tt.fields.Structure,
				Actions:   tt.fields.Actions,
				Gunnery:   tt.fields.Gunnery,
				Piloting:  tt.fields.Piloting,
				EW:        tt.fields.EW,
				Weapons:   tt.fields.Weapons,
				Traits:    tt.fields.Traits,
				Type:      tt.fields.Type,
				Height:    tt.fields.Height,
				Upgrades:  tt.fields.Upgrades,
			}
			if got := m.IsUA(tt.args.UA); got != tt.want {
				t.Errorf("Model.IsUA() = %v, want %v", got, tt.want)
			}
		})
	}
}

func TestModels_FilterByUA(t *testing.T) {
	testModelFunc := func(ua string, number uint16) Models {
		models := Models{}

		for i := 0; i < int(number); i++ {
			models = append(models, Model{UA: []string{ua}})
		}

		return models
	}
	type args struct {
		UA string
	}
	tests := []struct {
		name string
		m    Models
		args args
		want Models
	}{
		{
			name: "model with UA exists",
			m:    testModelFunc("GP", 5),
			args: args{UA: "GP"},
			want: testModelFunc("GP", 5),
		},
		{
			name: "model with UA doesn't exist",
			m:    testModelFunc("GP", 5),
			args: args{UA: "FS"},
			want: Models{},
		},
	}
	for _, tt := range tests {
		t.Run(tt.name, func(t *testing.T) {
			if got := tt.m.FilterByUA(tt.args.UA); !reflect.DeepEqual(got, tt.want) {
				t.Errorf("Models.FilterByUA() = %v, want %v", got, tt.want)
			}
		})
	}
}
