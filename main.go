package main

import (
	"fmt"
	"strings"

	"fyne.io/fyne"
	"fyne.io/fyne/app"
	"fyne.io/fyne/layout"
	"fyne.io/fyne/widget"

	"github.com/Ariemeth/gearforce/notifier"
	"github.com/Ariemeth/gearforce/unit"
)

const (
	windowTitle    = "Heavy Gear Blitz 3.0 Force Builder"
	startingWidth  = 700
	startingHeight = 400
)

func main() {

	a := app.New()

	w := a.NewWindow(windowTitle)
	w.Resize(fyne.NewSize(startingWidth, startingHeight))
	w.CenterOnScreen()
	w.SetContent(buildMainWindow(a))

	w.ShowAndRun()
}

func buildMainWindow(app fyne.App) fyne.CanvasObject {

	faction := notifier.String{}
	// Configure the Faction select
	factionSelect := widget.NewSelect(factionList(), func(s string) {
		faction.Set(s)
	})
	factionSelect.PlaceHolder = "Select Faction"

	// Configure the subfaction select
	subfactionSelect := widget.NewSelect([]string{}, func(s string) {

	})
	subfactionSelect.PlaceHolder = "Select faction sub-list"
	subfactionUpdate := make(chan string)
	go func() {
		for {
			select {
			case factionName := <-subfactionUpdate:
				subfactionSelect.Options = getSubLists(factionName)
				subfactionSelect.ClearSelected()
			}
		}
	}()
	faction.Subscribe("subfaction-update", subfactionUpdate)

	sublistItem := widget.NewFormItem("Sub-list:", subfactionSelect)

	// Create combat group display
	forceDisplay := buildForceDisplay(&faction)

	pointsDisplay := widget.NewLabel("0")

	w := widget.NewVBox(
		widget.NewForm(
			widget.NewFormItem("Player Name:", widget.NewEntry()),
			widget.NewFormItem("Force Name:", widget.NewEntry()),
		),
		widget.NewForm(
			widget.NewFormItem("Faction:", factionSelect),
			sublistItem,
		),
		widget.NewForm(
			widget.NewFormItem("Points:", pointsDisplay),
		),
		forceDisplay,
		widget.NewButton("Quit", func() {
			app.Quit()
		}))

	return w
}

func buildForceDisplay(faction notifier.ReadOnlyString) fyne.CanvasObject {

	w := widget.NewVBox()

	tabMenu := widget.NewTabContainer(widget.NewTabItem("CG1", buildCombatGroup(faction)))
	addCombatGroupButton := widget.NewButton("Add CG", func() {
		tabMenu.Append(widget.NewTabItem(fmt.Sprintf("CG%d", len(tabMenu.Items)+1), buildCombatGroup(faction)))
	})

	w.Append(widget.NewHBox(addCombatGroupButton))
	w.Append(tabMenu)

	return w
}

func buildCombatGroup(faction notifier.ReadOnlyString) fyne.CanvasObject {

	cg := widget.NewVBox()

	primaryUASelection := widget.NewSelect(uaLists(), func(string) {})
	primaryUAPoints := widget.NewLabel("0")
	primaryUAActions := widget.NewLabel("0")
	primaryUnits := widget.NewHBox()
	primaryInfo := widget.NewVBox(
		widget.NewHBox(widget.NewLabel("UA"), widget.NewHBox(primaryUASelection)),
		widget.NewHBox(widget.NewLabel("Points"), primaryUAPoints),
		widget.NewHBox(widget.NewLabel("Actions"), primaryUAActions),
		widget.NewHBox(widget.NewButton("Add Unit",
			func() {
				w := fyne.CurrentApp().NewWindow("Units")
				fmt.Printf("Getting units for %s\n", faction.Get())
				units := unit.GetFactionUnits(faction.Get())

				unitDisplay :=(buildUnitCard(units[0]))
				w.SetContent(unitDisplay)
				w.CenterOnScreen()
				w.Show()
			})),
	)

	primary := widget.NewGroup(
		"Primary",
		fyne.NewContainerWithLayout(
			layout.NewBorderLayout(
				nil,
				nil,
				primaryInfo,
				nil,
			),
			primaryInfo,
			widget.NewHScrollContainer(primaryUnits),
		))

	secondaryUASelection := widget.NewSelect(uaLists(), func(string) {})
	secondaryUAPoints := widget.NewLabel("0")
	secondaryUAActions := widget.NewLabel("0")
	secondaryInfo := widget.NewVBox(
		widget.NewHBox(widget.NewLabel("UA"), widget.NewHBox(secondaryUASelection)),
		widget.NewHBox(widget.NewLabel("Points"), secondaryUAPoints),
		widget.NewHBox(widget.NewLabel("Actions"), secondaryUAActions),
	)

	secondaryUnits := widget.NewHScrollContainer(widget.NewHBox())

	secondary := widget.NewGroup(
		"Secondary",
		fyne.NewContainerWithLayout(
			layout.NewBorderLayout(
				nil,
				nil,
				secondaryInfo,
				nil,
			),
			secondaryInfo,
			secondaryUnits,
		))

	cg.Append(primary)
	cg.Append(secondary)

	return cg
}

func buildUnitCard(u unit.Model) fyne.CanvasObject {
	g := unit.Hunter

	f := widget.NewForm(
		widget.NewFormItem("UA", widget.NewLabel(strings.Join(u.UA, ","))),
		widget.NewFormItem("field2", widget.NewLabel("test2")),
		widget.NewFormItem("Model:", widget.NewLabel(fmt.Sprintf("%s %s", g.Model, g.SubModel))),
		widget.NewFormItem("TV:", widget.NewLabel(fmt.Sprintf("%d", g.TV))),
		widget.NewFormItem("Armor:", widget.NewLabel(fmt.Sprintf("%d", g.Armor))),
		widget.NewFormItem("H/S:", widget.NewLabel(fmt.Sprintf("%d/%d", g.Hull, g.Structure))),
	)

	return widget.NewVBox(f)
}

func factionList() []string {
	return []string{
		unit.North,
		unit.South,
		unit.PeaceRiver,
	}
}

func getSubLists(faction string) []string {
	switch faction {
	case unit.North:
		return northSubLists()
	case unit.South:
		return southSubLists()
	case unit.PeaceRiver:
		return peaceRiverSubLists()
	}
	return []string{}
}

func uaLists() []string {
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

func northSubLists() []string {
	return []string{
		"Northern Guard",
		"Western Frontier Protectorate",
		"United Mercantile Federation",
		"Northern Lights Confederacy",
	}
}

func southSubLists() []string {
	return []string{
		"MILitary Intervention and Counter Insurgency Army",
		"Southern Republic Army",
		"Mekong Dominion",
		"Eastern Sun Emirates",
		"Humanist Alliance Protection Force",
	}
}

func peaceRiverSubLists() []string {
	return []string{
		"Peace River Defense Force",
		"Peace Officer Corps",
		"Home Guard Security Forces",
		"Combined Task Force",
		"Protectorate Sponsored Badlands Militia",
	}
}
